### 账户的创建和配置

你所需要做的第一件事是创建一个免费账户。 直接访问
[https://github.com](https://github.com)，选择一个未被占用的用户名，提供一个电子邮件地址和密码，点击写着“Sign
up for GitHub”的绿色大按钮即可。

![GitHub 注册表单。](../../../../../images/progit/signup.png)

Figure 1. GitHub 注册表单。

你将看到的下一个页面是升级计划的价格页面，目前我们可以直接忽略这个页面。
GitHub 会给你提供的邮件地址发送一封验证邮件。
尽快到你的邮箱进行验证，这是非常重要的（我们会在后面了解到这点）。

[TABLE]

点击屏幕左上角的章鱼猫（Octocat）图标，你将来到控制面板页面。
现在，你已经做好了使用 GitHub 的准备工作。

#### SSH 访问

现在，你完全可以使用 `https://` 协议，通过你刚刚创建的用户名和密码访问
Git 版本库。
但是，如果仅仅克隆公有项目，你甚至不需要注册——刚刚我们创建的账户是为了以后
fork 其它项目，以及推送我们自己的修改。

如果你习惯使用 SSH 远程，你需要配置一个公钥。 （如果你没有公钥，参考
[ch04-git-on-the-server](ch04-git-on-the-server.md#generate_ssh_key)。）
使用窗口右上角的链接打开你的账户设置：

![“Account settings”链接。](../../../../../images/progit/account-settings.png)

Figure 2. “Account settings”链接。

然后在左侧选择“SSH keys”部分。

![“SSH keys”链接。](../../../../../images/progit/ssh-keys.png)

Figure 3. “SSH keys”链接。

在这个页面点击“`Add an SSH key`”按钮，给你的公钥起一个名字，将你的
`~/.ssh/id_rsa.pub`
（或者自定义的其它名字）公钥文件的内容粘贴到文本区，然后点击“Add key”。

[TABLE]

#### 头像

下一步，如果愿意的话，你可以将生成的头像换成你喜欢的图片。
首先，来到“Profile”标签页（在“SSH Keys”标签页上方），点击“Upload new
picture”。

![“Profile”链接。](../../../../../images/progit/your-profile.png)

Figure 4. “Profile”链接。

我们选择了本地磁盘上的一个 Git 图标，上传之后还可以对其进行裁剪。

![裁剪已上传的头像。](../../../../../images/progit/avatar-crop.png)

Figure 5. 裁剪头像

现在，在网站任意有你参与的位置，人们都可以在你的用户名旁边看到你的头像。

如果你已经把头像上传到了流行的 Gravatar 托管服务（Wordpress
账户经常使用），默认就会使用这个头像，因此，你就不需要进行这一步骤了。

#### 邮件地址

GitHub 使用用户邮件地址区分 Git 提交。
如果你在自己的提交中使用了多个邮件地址，希望 GitHub
可以正确地将它们连接起来， 你需要在管理页面的 Emails
部分添加你拥有的所有邮箱地址。

![添加所有邮件地址。](../../../../../images/progit/email-settings.png)

Figure 6. 添加邮件地址

在 [添加邮件地址](#_add_email_addresses) 中我们可以看到一些不同的状态。
顶部的地址是通过验证的，并且被设置为主要地址，这意味着该地址会接收到所有的通知和回复。
第二个地址是通过验证的，如果愿意的话，可以将其设置为主要地址。
最后一个地址是未通过验证的，这意味着你不能将其设置为主要地址。 当 GitHub
发现任意版本库中的任意提交信息包含了这些地址，它就会将其链接到你的账户。

#### 两步验证

最后，为了额外的安全性，你绝对应当设置两步验证，简写为 “2FA”。
两步验证是一种用于降低因你的密码被盗而带来的账户风险的验证机制，现在已经变得越来越流行。
开启两步验证，GitHub
会要求你用两种不同的验证方法，这样，即使其中一个被攻破，攻击者也不能访问你的账户。

你可以在 Account settings 页面的 Security 标签页中找到 Two-factor
Authentication 设置。

![Security 标签页中的 2FA](../../../../../images/progit/2fa-1.png)

Figure 7. Security 标签页中的 2FA

点击“Set up two-factor
authentication”按钮，会跳转到设置页面。该页面允许你选择是要在登录时使用手机
app 生成辅助码（一种“基于时间的一次性密码”），还是要 GitHub 通过 SMS
发送辅助码。

选择合适的方法后，按照提示步骤设置 2FA，你的账户会变得更安全，每次登录
GitHub 时都需要提供除密码以外的辅助码。

Last updated 2024-03-09 10:37:33 +0800
