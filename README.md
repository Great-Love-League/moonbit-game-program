# moonbit game of [Great-Love-League](https://github.com/Great-Love-League)

## 从 $vscode$ 中使用 git&github

### 配置 $SSH$

$SSH(Secure Shell)$ 是一种网络协议，用于在不安全的网络上安全地访问和管理计算机。它提供了加密的通信渠道，主要用于远程登录和执行命令。这里仅仅简单介绍一下如何使用 $SSH$ 与 $github$ 建立连接

1. 首先在$C$盘中找到 ``.ssh`` 文件夹，这个通常在 ``C:\Users\username`` 这个里面，其中 ``username`` 指的是你的电脑用户名

2. 在 ``.ssh`` 中右键打开命令行，输入如下命令开始创建 $ssh$ 密钥

   ```
   ssh-keygen -t rsa -b 4096
   ```

   接下来会输入用户名与密钥

3. 然后在 ``.ssh`` 文件夹中创建 ``config`` 文件，在其中写入

   ```
   # GitHub
   Host github.com
   HostName github.com
   PreferredAuthentications publickey
   IdentityFile ~/.ssh/你刚刚打的用户名
   ```

4. 接下来用记事本打开 ``.ssh`` 中的 $你刚刚打的用户名.pub$ 文件，将其中的公钥复制。打开 $github$ 在 $settings$ 中找到 $SSH~and~GPG~keys$ 在 $SSH~key$ 中加入公钥即可。

   ![image-20240923233743997](https://cdn.luogu.com.cn/upload/image_hosting/kwxta3t6.png)

5. 然后用 ``ssh -T git@github.com`` 命令检查是否成功。成功过后可以得到的是 ``Hi Demonmasterlqx! You've successfully authenticated, but GitHub does not provide shell access.`` 

### 使用 GitHub Desktop

其实使用 $GitHub~Desktop$ 可以直接避免以上 $SSH$ 的麻烦

从网页端下载这个软件后直接 $clone~repository$ 就可以在 $vscode$ 中直接打开了

![image-20240923235353499](https://cdn.luogu.com.cn/upload/image_hosting/odyivopb.png)

### 在 $vscode$ 中使用 $git$

首先在 [git 官网](https://git-scm.com/download/win) 下载 $git$ ，并且在 $vscode$ 安装 $git$ 插件。

为了简化，在这里尽量不讲git命令，使用vscode中的图形化界面

#### 面板介绍