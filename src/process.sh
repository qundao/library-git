#!/bin/bash
set -eu

# 检查输入参数
if [ $# -ne 2 ] || [ ! -d "$1" ]; then
  echo "Usage: $0 input_directory output_directory"
  exit 1
fi

# 函数：确保目标目录存在
ensure_output_directory_exists() {
  local tgt_dir="$1"
  if [ ! -d "$tgt_dir" ]; then
    echo "Creating output directory: $tgt_dir"
    mkdir -p "$tgt_dir"
  fi
}

# 递归处理目录中的文件
function process_directory {
  local input_directory="$1"
  local output_directory="$2"
  ensure_output_directory_exists "$output_directory"

  for file_or_dir in "$input_directory"/*; do
    if [[ -d "$file_or_dir" ]]; then
      filename=$(basename -- "$file_or_dir")
      if [[ "$filename" == "images" ]] || [[ "$filename" == "callouts" ]] || [[ "$filename" == "theme" ]]; then
        continue
      fi
      relative_path="${file_or_dir#$input_directory}"
      process_directory "$file_or_dir" "$output_directory$relative_path"
    
    elif [[ -f "$file_or_dir" ]]; then
      filename=$(basename -- "$file_or_dir")
      extension="${filename##*.}"
      if [[ "$extension" = "asc" ]]; then
        filestem="${filename%.*}"
        input_filename=$file_or_dir
        output_filename="$output_directory/$filestem.md"

        if [[ -f "$output_filename" ]]; then
          continue
        fi

        gsed -i 's/include::\(.*\/\(.*\)\)\.asc\[\]/. link:\1[\2]/g' "$input_filename" && \
        asciidoctor -b html5 "$input_filename" -o -   | \
        pandoc -f html -t gfm-raw_html -o "$output_filename" && \
        gsed -i -e 's/``` highlight/```shell/g' \
          -e 's/\(](book\/[^)]*\))/\1.md)/g' \
          -e 's/\.html](\([^)]*\).html#_\?\([^)]*\))/](\1.md#\2)/g' \
          -e 's/](\(images\/[^)]*\.png\))/](..\/..\/..\/..\/\1)/g' \
          "$output_filename"

      fi
    fi
  done
}

# 执行处理函数
process_directory "$1" "$2"
