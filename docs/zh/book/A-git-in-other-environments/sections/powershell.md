### Git 在 PowerShell 中使用 Git

Windows 中早期的命令行终端 `cmd.exe` 无法自定义 Git
使用体验，但是如果你正在使用 Powershell，那么你就十分幸运了。
这种方法同样适用于 Linux 或 macOS 上运行的 PowerShell Core。 一个名为
Posh-Git
([https://github.com/dahlbyk/posh-git](https://github.com/dahlbyk/posh-git))
的扩展包提供了强大的 tab 补全功能，
并针对提示符进行了增强，以帮助你聚焦于你的仓库状态。 它看起来像：

![附带了 Posh-Git 扩展包的 Powershell](../../../../images/posh-git.png)

Figure 1. 附带了 Posh-Git 扩展包的 Powershell。

#### 安装

##### 前提需求（仅限 Windows）

在可以运行 PowerShell 脚本之前，你需要将本地的 ExecutionPolicy 设置为
RemoteSigned （可以说是允许除了 Undefined 和 Restricted
之外的任何内容）。如果你选择了 AllSigned 而非
RemoteSigned，那么你的本地脚本还需要数字签名后才能执行。如果设置为
RemoteSigned， 那么只有“ZoneIdentifier”设置为 Internet，即从 Web
上下载的脚本才需要签名，其它则不需要。
如果你是管理员，想要为本机上的所有用户设置它，请使用“-Scope
LocalMachine”。 如果你是没有管理权限的普通用户，可使用“-Scope
CurrentUser”来只为自己设置它。

有关 PowerShell Scopes 的更多详情：
[https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes)

有关 PowerShell ExecutionPolicy 的更多详情：
[https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy)

```shell
> Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned -Force
```

##### PowerShell Gallery

如果你有 PowerShell 5 以上或安装了 PackageManagement 的 PowerShell
4，那么可以用包管理器来安装 posh-git。

有关 PowerShell Gallery 的更多详情：
[https://docs.microsoft.com/en-us/powershell/scripting/gallery/overview](https://docs.microsoft.com/en-us/powershell/scripting/gallery/overview)

```shell
> Install-Module posh-git -Scope CurrentUser -Force
> Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force # 带有 PowerShell Core 支持的更新的 beta 版
```

如果你想为所有的用户安装 posh-git，请使用“-Scope
AllUsers”并在管理员权限启动的 PowerShell 控制台中执行。
如果第二条命令执行失败并出现类似
`Module 'PowerShellGet' was not installed by using Install-Module`
这样的错误， 那么你需要先运行另一条命令：

```shell
> Install-Module PowerShellGet -Force -SkipPublisherCheck
```

之后你可以再试一遍。出现这个错误的原因是 Windows PowerShell
搭载的模块是以不同的发布证书签名的。

##### 更新 PowerShell 提示符

要在你的提示符中包含 Git 信息，那么需要导入 Posh-Git 模块。 要让
PowerShell 在每次启动时都导入 Posh-Git，请执行 Add-PoshGitToProfile
命令， 它会在你的 \$profile 脚本中添加导入语句。此脚本会在每次打开新的
PowerShell 终端时执行。 注意，存在多个 \$profile
脚本。例如，其中一个是控制台的，另一个则属于 ISE。

```shell
> Import-Module posh-git
> Add-PoshGitToProfile -AllHosts
```

##### 从源码安装

只需从
([https://github.com/dahlbyk/posh-git](https://github.com/dahlbyk/posh-git))
下载一份 Posh-Git 的发行版并解压即可。 接着使用 posh-git.psd1
文件的完整路径导入此模块：

```shell
> Import-Module <path-to-uncompress-folder>\src\posh-git.psd1
> Add-PoshGitToProfile -AllHosts
```

它将会向你的 `profile.ps1` 文件添加适当的内容，Posh-Git 将会在下次打开
PowerShell 时启用。 命令提示符显示的 Git 状态信息的解释见：
[https://github.com/dahlbyk/posh-git/blob/master/README.md#git-status-summary-information](https://github.com/dahlbyk/posh-git/blob/master/README.md#git-status-summary-information)
如何定制 Posh-Git 提示符的详情见：
[https://github.com/dahlbyk/posh-git/blob/master/README.md#customization-variables](https://github.com/dahlbyk/posh-git/blob/master/README.md#customization-variables)

Last updated 2024-03-09 10:37:49 +0800
