### 安装 Git

在你开始使用 Git 前，需要将它安装在你的计算机上。
即便已经安装，最好将它升级到最新的版本。
你可以通过软件包或者其它安装程序来安装，或者下载源码编译安装。

[TABLE]

#### 在 Linux 上安装

如果你想在 Linux 上用二进制安装程序来安装基本的 Git
工具，可以使用发行版包含的基础软件包管理工具来安装。 以 Fedora
为例，如果你在使用它（或与之紧密相关的基于 RPM 的发行版，如 RHEL 或
CentOS），你可以使用 `dnf`：

```shell
$ sudo dnf install git-all
```

如果你在基于 Debian 的发行版上，如 Ubuntu，请使用 `apt`：

```shell
$ sudo apt install git-all
```

要了解更多选择，Git 官方网站上有在各种 Unix
发行版的系统上安装步骤，网址为
[https://git-scm.com/download/linux](https://git-scm.com/download/linux)。

#### 在 macOS 上安装

在 Mac 上安装 Git 有多种方式。 最简单的方法是安装 Xcode Command Line
Tools。 Mavericks （10.9） 或更高版本的系统中，在 Terminal
里尝试首次运行 'git' 命令即可。

```shell
$ git --version
```

如果没有安装过命令行开发者工具，将会提示你安装。

如果你想安装更新的版本，可以使用二进制安装程序。 官方维护的 macOS Git
安装程序可以在 Git 官方网站下载，网址为
[https://git-scm.com/download/mac](https://git-scm.com/download/mac)。

![Git macOS 安装程序。](../../../../../images/progit/git-osx-installer.png)

Figure 1. Git macOS Installer.

你也可以将它作为 GitHub for macOS 的一部分来安装。 它们的图形化 Git
工具有一个安装命令行工具的选项。 你可以从 GitHub for macOS
网站下载该工具，网址为
[https://mac.github.com](https://mac.github.com)。

#### 在 Windows 上安装

在 Windows 上安装 Git 也有几种安装方法。 官方版本可以在 Git
官方网站下载。 打开
[https://git-scm.com/download/win](https://git-scm.com/download/win)，下载会自动开始。
要注意这是一个名为 Git for Windows 的项目（也叫做 msysGit），和 Git
是分别独立的项目；更多信息请访问
[http://msysgit.github.io/](http://msysgit.github.io/)。

要进行自动安装，你可以使用 [Git Chocolatey
包](https://chocolatey.org/packages/git)。 注意 Chocolatey
包是由社区维护的。

另一个简单的方法是安装 GitHub Desktop。
该安装程序包含图形化和命令行版本的 Git。 它也能支持
Powershell，提供了稳定的凭证缓存和健全的换行设置。
稍后我们会对这方面有更多了解，现在只要一句话就够了，这些都是你所需要的。
你可以在 GitHub for Windows 网站下载，网址为 [GitHub Desktop
网站](https://desktop.github.com)。

#### 从源代码安装

有人觉得从源码安装 Git 更实用，因为你能得到最新的版本。
二进制安装程序倾向于有一些滞后，当然近几年 Git
已经成熟，这个差异不再显著。

如果你想从源码安装 Git，需要安装 Git
依赖的库：autotools、curl、zlib、openssl、expat 和 libiconv。
如果你的系统上有 `dnf` （如 Fedora）或者 `apt`（如基于 Debian 的系统），
可以使用对应的命令来安装最少的依赖以便编译并安装 Git 的二进制版：

```shell
$ sudo dnf install dh-autoreconf curl-devel expat-devel gettext-devel \
  openssl-devel perl-devel zlib-devel
$ sudo apt-get install dh-autoreconf libcurl4-gnutls-dev libexpat1-dev \
  gettext libz-dev libssl-dev
```

为了添加文档的多种格式（doc、html、info），需要以下附加的依赖：

```shell
$ sudo dnf install asciidoc xmlto docbook2X
$ sudo apt-get install asciidoc xmlto docbook2x
```

[TABLE]

如果你使用基于 Debian
的发行版（Debian/Ubuntu/Ubuntu-derivatives），你也需要 `install-info`
包：

```shell
$ sudo apt-get install install-info
```

如果你使用基于 RPM 的发行版（Fedora/RHEL/RHEL衍生版），你还需要 `getopt`
包 （它已经在基于 Debian 的发行版中预装了）：

```shell
$ sudo dnf install getopt
```

此外，如果你使用 Fedora/RHEL/RHEL衍生版，那么你需要执行以下命令：

```shell
$ sudo ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi
```

以此来解决二进制文件名的不同。

当你安装好所有的必要依赖，你可以继续从几个地方来取得最新发布版本的 tar
包。 你可以从 Kernel.org 网站获取，网址为
[https://www.kernel.org/pub/software/scm/git](https://www.kernel.org/pub/software/scm/git)，
或从 GitHub 网站上的镜像来获得，网址为
[https://github.com/git/git/releases](https://github.com/git/git/releases)。
通常在 GitHub 上的是最新版本，但 kernel.org
上包含有文件下载签名，如果你想验证下载正确性的话会用到。

接着，编译并安装：

```shell
$ tar -zxf git-2.8.0.tar.gz
$ cd git-2.8.0
$ make configure
$ ./configure --prefix=/usr
$ make all doc info
$ sudo make install install-doc install-html install-info
```

完成后，你可以使用 Git 来获取 Git 的更新：

```shell
$ git clone git://git.kernel.org/pub/scm/git/git.git
```

Last updated 2024-03-09 10:37:22 +0800
