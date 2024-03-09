#!/bin/bash
set -eux

base="../orignal"
docs="../docs"
temp="./temp"

repos=("progit2" "progit2-zh")
targets=("$temp/en" "$temp/zh")

mkdir -p "$temp"
length=${#repos[@]}
for ((i = 0; i < length; i++)); do
    echo "${targets[i]} ${repos[i]}"
    if [[ -d "${targets[i]}" ]]; then
        echo "remove"
        # rm -r "${targets[i]}"
    else
        echo "copy files"
        mkdir -p "${targets[i]}"
        cp -r "$base/${repos[i]}"/{book,callouts,images,theme} "${targets[i]}"/
        cp "$base/${repos[i]}/"*.asc "${targets[i]}"/
        rm "${targets[i]}"/{progit,README,TRANSLATION_NOTES}.asc
    fi
    touch "${targets[i]}/book/contributors.txt"
    bash process.sh "${targets[i]}" "${targets[i]}-out"
    echo "copy docs"
    rsync -avm --include="*/" --include="*.md" --exclude="*" "${targets[i]}-out/" "$docs/${targets[i]}"
done

echo "copy images"
rsync -avm --include="*/" --include="*.png" --exclude="*" "$base/${repos[0]}/images" "$docs/"

echo "remove some doc"
rm "$docs"/*/book/{toc,license}.md
rm "$docs"/*/index/.md

ecno "clean $temp"
rm -r "$temp"
