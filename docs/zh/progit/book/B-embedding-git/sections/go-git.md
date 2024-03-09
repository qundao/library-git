### go-git

如果你想将 Git 集成到用 Golang 编写的服务中，这里还有一个纯 Go
库的实现。
这个库的实现没有任何原生依赖，因此不易出现手动管理内存的错误。
它对于标准 Golang 性能分析工具（如
CPU、内存分析器、竞争检测器等）也是透明的。

go-git 专注于可扩展性、兼容性并支持大多数管道 API，记录在
[https://github.com/go-git/go-git/blob/master/COMPATIBILITY.md](https://github.com/go-git/go-git/blob/master/COMPATIBILITY.md).

以下是使用 Go API 的基本示例：

```shell
import  "gopkg.in/src-d/go-git.v4"

r, err := git.PlainClone("/tmp/foo", false, &git.CloneOptions{
    URL:      "https://github.com/src-d/go-git",
    Progress: os.Stdout,
})
```

你只要拥有一个 `Repository` 实例，就可以访问相应仓库信息并对其进行改变：

```shell
// 获取 HEAD 指向的分支
ref, err := r.Head()

// 获取由 ref 指向的提交对象
commit, err := r.CommitObject(ref.Hash())

// 检索提交历史
history, err := commit.History()

// 遍历并逐个打印提交
for _, c := range history {
    fmt.Println(c)
}
```

#### 高级功能

go-git 几乎没有值得注意的高级功能，其中之一是可插拔存储系统，类似于
Libgit2 后端。 默认实现是内存存储，速度非常快。

```shell
r, err := git.Clone(memory.NewStorage(), nil, &git.CloneOptions{
    URL: "https://github.com/src-d/go-git",
})
```

可插拔存储提供了许多有趣的选项。
例如，https://github.com/go-git/go-git/tree/master/\_examples/storage\[\]
允许你在 Aerospike 数据库中存储引用、对象和配置。

另一个特性是灵活的文件系统抽象。 使用
[https://godoc.org/github.com/src-d/go-billy#Filesystem](https://godoc.org/github.com/src-d/go-billy#Filesystem)
可以很容易以不同的方式存储所有文件，即通过将所有文件打包到磁盘上的单个归档文件或保存它们都在内存中。

另一个高级用例包括一个可微调的 HTTP 客户端，例如
[https://github.com/go-git/go-git/blob/master/\_examples/custom_http/main.go](https://github.com/go-git/go-git/blob/master/_examples/custom_http/main.go)
中的案例。

```shell
customClient := &http.Client{
    Transport: &http.Transport{ // 接受任何证书（可能对测试有用）
        TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
    },
    Timeout: 15 * time.Second,  // 15 秒超时
        CheckRedirect: func(req *http.Request, via []*http.Request) error {
        return http.ErrUseLastResponse // 不要跟随重定向
    },
}

// 覆盖 http(s) 默认协议以使用我们的自定义客户端
client.InstallProtocol("https", githttp.NewClient(customClient))

// 如果协议为 https://，则使用新客户端克隆存储库
r, err := git.Clone(memory.NewStorage(), nil, &git.CloneOptions{URL: url})
```

#### 延伸阅读

对 go-git 功能的全面介绍超出了本书的范围。 如果您想了解有关 go-git
的更多信息，请参阅
[https://godoc.org/gopkg.in/src-d/go-git.v4](https://godoc.org/gopkg.in/src-d/go-git.v4)
上的 API 文档， 以及
[https://github.com/go-git/go-git/tree/master/\_examples](https://github.com/go-git/go-git/tree/master/_examples)
上的系列使用示例。

Last updated 2024-03-09 10:37:52 +0800
