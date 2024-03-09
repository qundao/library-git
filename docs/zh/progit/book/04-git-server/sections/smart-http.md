### Smart HTTP

我们一般通过 SSH 进行授权访问，通过 git://
进行无授权访问，但是还有一种协议可以同时实现以上两种方式的访问。 设置
Smart HTTP 一般只需要在服务器上启用一个 Git 自带的名为
`git-http-backend` 的 CGI 脚本。 该 CGI 脚本将会读取由 `git fetch` 或
`git push` 命令向 HTTP URL 发送的请求路径和头部信息，
来判断该客户端是否支持 HTTP 通信（不低于 1.6.6
版本的客户端支持此特性）。 如果 CGI
发现该客户端支持智能（Smart）模式，它将会以智能模式与它进行通信，
否则它将会回落到哑（Dumb）模式下（因此它可以对某些老的客户端实现向下兼容）。

在完成以上简单的安装步骤后， 我们将用 Apache 来作为 CGI 服务器。
如果你没有安装 Apache，你可以在 Linux 环境下执行如下或类似的命令来安装：

```shell
$ sudo apt-get install apache2 apache2-utils
$ a2enmod cgi alias env
```

该操作将会启用 `mod_cgi`， `mod_alias` 和 `mod_env` 等 Apache 模块，
这些模块都是使该功能正常工作所必须的。

你还需要将 `/srv/git` 的 Unix 用户组设置为 `www-data`，这样 Web
服务器才能读写该仓库， 因为运行 CGI 脚本的 Apache
实例默认会以该用户的权限运行：

```shell
$ chgrp -R www-data /srv/git
```

接下来我们要向 Apache 配置文件添加一些内容，来让 `git-http-backend` 作为
Web 服务器对 `/git` 路径请求的处理器。

```shell
SetEnv GIT_PROJECT_ROOT /srv/git
SetEnv GIT_HTTP_EXPORT_ALL
ScriptAlias /git/ /usr/lib/git-core/git-http-backend/
```

如果留空 `GIT_HTTP_EXPORT_ALL` 这个环境变量，Git
将只对无授权客户端提供带 `git-daemon-export-ok` 文件的版本库，就像 Git
守护进程一样。

最后，如果想让 Apache 允许 `git-http-backend`
请求并实现写入操作的授权验证，使用如下授权屏蔽配置即可：

```shell
<Files "git-http-backend">
    AuthType Basic
    AuthName "Git Access"
    AuthUserFile /srv/git/.htpasswd
    Require expr !(%{QUERY_STRING} -strmatch '*service=git-receive-pack*' || %{REQUEST_URI} =~ m#/git-receive-pack$#)
    Require valid-user
</Files>
```

这需要你创建一个包含所有合法用户密码的 `.htpasswd` 文件。 以下是一个添加
“schacon” 用户到此文件的例子：

```shell
$ htpasswd -c /srv/git/.htpasswd schacon
```

你可以通过许多方式添加 Apache 授权用户，选择使用其中一种方式即可。
以上仅仅只是我们可以找到的最简单的一个例子。 如果愿意的话，你也可以通过
SSL 运行它，以保证所有数据是在加密状态下进行传输的。

我们不想深入去讲解 Apache 配置文件，因为你可能会使用不同的 Web
服务器，或者可能有不同的授权需求。 它的主要原理是使用一个 Git
附带的，名为 `git-http-backend` 的 CGI。它被引用来处理协商通过 HTTP
发送和接收的数据。 它本身并不包含任何授权功能，但是授权功能可以在 Web
服务器层引用它时被轻松实现。 你可以在任何所有可以处理 CGI 的 Web
服务器上办到这点，所以随便挑一个你最熟悉的 Web 服务器试手吧。

[TABLE]

Last updated 2024-03-09 10:37:31 +0800
