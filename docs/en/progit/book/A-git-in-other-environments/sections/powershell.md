### Git in PowerShell

The legacy command-line terminal on Windows (`cmd.exe`) isn’t really
capable of a customized Git experience, but if you’re using PowerShell,
you’re in luck. This also works if you’re running PowerShell Core on
Linux or macOS. A package called posh-git
([https://github.com/dahlbyk/posh-git](https://github.com/dahlbyk/posh-git))
provides powerful tab-completion facilities, as well as an enhanced
prompt to help you stay on top of your repository status. It looks like
this:

![PowerShell with Posh-git](../../../../../images/progit/posh-git.png)

Figure 1. PowerShell with Posh-git

#### Installation

##### Prerequisites (Windows only)

Before you’re able to run PowerShell scripts on your machine, you need
to set your local `ExecutionPolicy` to `RemoteSigned` (basically,
anything except `Undefined` and `Restricted`). If you choose `AllSigned`
instead of `RemoteSigned`, also local scripts (your own) need to be
digitally signed in order to be executed. With `RemoteSigned`, only
scripts having the `ZoneIdentifier` set to `Internet` (were downloaded
from the web) need to be signed, others not. If you’re an administrator
and want to set it for all users on that machine, use
`-Scope LocalMachine`. If you’re a normal user, without administrative
rights, you can use `-Scope CurrentUser` to set it only for you.

More about PowerShell Scopes:
[https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_scopes).

More about PowerShell ExecutionPolicy:
[https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy).

To set the value of `ExecutionPolicy` to `RemoteSigned` for all users
use the next command:

```shell
> Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned -Force
```

##### PowerShell Gallery

If you have at least PowerShell 5 or PowerShell 4 with PackageManagement
installed, you can use the package manager to install posh-git for you.

More information about PowerShell Gallery:
[https://learn.microsoft.com/en-us/powershell/scripting/gallery/overview](https://learn.microsoft.com/en-us/powershell/scripting/gallery/overview).

```shell
> Install-Module posh-git -Scope CurrentUser -Force
> Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force # Newer beta version with PowerShell Core support
```

If you want to install posh-git for all users, use `-Scope AllUsers`
instead and execute the command from an elevated PowerShell console. If
the second command fails with an error like
`Module 'PowerShellGet' was not installed by using Install-Module`,
you’ll need to run another command first:

```shell
> Install-Module PowerShellGet -Force -SkipPublisherCheck
```

Then you can go back and try again. This happens, because the modules
that ship with Windows PowerShell are signed with a different
publishment certificate.

##### Update PowerShell Prompt

To include Git information in your prompt, the posh-git module needs to
be imported. To have posh-git imported every time PowerShell starts,
execute the `Add-PoshGitToProfile` command which will add the import
statement into your `$profile` script. This script is executed everytime
you open a new PowerShell console. Keep in mind, that there are multiple
`$profile` scripts. E.g. one for the console and a separate one for the
ISE.

```shell
> Import-Module posh-git
> Add-PoshGitToProfile -AllHosts
```

##### From Source

Just download a posh-git release from
[https://github.com/dahlbyk/posh-git/releases](https://github.com/dahlbyk/posh-git/releases),
and uncompress it. Then import the module using the full path to the
`posh-git.psd1` file:

```shell
> Import-Module <path-to-uncompress-folder>\src\posh-git.psd1
> Add-PoshGitToProfile -AllHosts
```

This will add the proper line to your `profile.ps1` file, and posh-git
will be active the next time you open PowerShell.

For a description of the Git status summary information displayed in the
prompt see:
[https://github.com/dahlbyk/posh-git/blob/master/README.md#git-status-summary-information](https://github.com/dahlbyk/posh-git/blob/master/README.md#git-status-summary-information)
For more details on how to customize your posh-git prompt see:
[https://github.com/dahlbyk/posh-git/blob/master/README.md#customization-variables](https://github.com/dahlbyk/posh-git/blob/master/README.md#customization-variables).

Last updated 2024-03-09 10:34:29 +0800
