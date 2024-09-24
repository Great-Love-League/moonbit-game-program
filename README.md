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

![image-20240924174401840](C:\Users\18384\AppData\Roaming\Typora\typora-user-images\image-20240924174401840.png)

打开git面板会有这三个东西，我们依次介绍

1. **源代码管理储存库**

   ![image-20240924175452943](C:\Users\18384\AppData\Roaming\Typora\typora-user-images\image-20240924175452943.png)

从左到右依次是仓库名称，当前分支名，同步，提交暂存，刷新，更多操作。

同步：如果这个仓库与远程仓库关联，点击这个按钮会将远程仓库的东西拉下来与本地合并（解决冲突）然后推送远端

刷新：刷新本地的修改

更多操作（基本上关于git的操作都在这里）：

![image-20240924180332177](C:\Users\18384\AppData\Roaming\Typora\typora-user-images\image-20240924180332177.png)

​	拉去推送字面意思，是本地仓库与远程仓库的交互。克隆是将远程仓库克隆到本地。

​	**提交**：

​	![image-20240924181119008](C:\Users\18384\AppData\Roaming\Typora\typora-user-images\image-20240924181119008.png)

​	这里的提交就是字面意思，但是大家会发现后面三个提交有“(修改)”，这个是可以将你这次提交与上一次提交相合并，减少提交数量，并且可以修改提交报文。

​	**储存：**

​	![image-20240924181542850](C:\Users\18384\AppData\Roaming\Typora\typora-user-images\image-20240924181542850.png)

​	这个适用于你要切换分支，但是暂存区和工作区还有未提交的文件，可以新建一个储存，将当前状态储存下来，在之后再切换回来。

​	然后这里弹出与应用的区别在于，弹出在应用所选储存的同时也会将对应储存删除。

