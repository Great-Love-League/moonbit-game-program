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

![image-20240924174401840](https://cdn.luogu.com.cn/upload/image_hosting/yd0isist.png)

打开git面板会有这三个东西，我们依次介绍

#### **源代码管理储存库**

![image-20240924175452943](https://cdn.luogu.com.cn/upload/image_hosting/di8zsyfr.png)

从左到右依次是仓库名称，当前分支名，同步，提交暂存，刷新，更多操作。

**同步：** 如果这个仓库与远程仓库关联，点击这个按钮会将远程仓库的东西拉下来与本地合并（解决冲突）然后推送远端

**刷新：** 刷新本地的修改

**更多操作（基本上关于git的操作都在这里）：**

![image-20240924180332177](https://cdn.luogu.com.cn/upload/image_hosting/x592xrl6.png)

​	**拉取推送克隆：** 拉取是指从远程仓库获取数据并立即尝试与本地分支合并。推送是将本地分支的更改推送到远程仓库。克隆是将远程仓库克隆到本地。

​	**抓取：** 只是取回远程仓库的数据，不自动合并。

​	**签出到：** 就是切换分支的意思，可以在这里面创建新的分支或者切换到现有分支（和直接点当前分支名是一个作用）

​	**提交**：

​	![image-20240924212342073](https://cdn.luogu.com.cn/upload/image_hosting/e8i1xdru.png)

​	这里的提交就是字面意思，但是大家会发现后面三个提交有“(修改)”，这个是可以将你这次提交与上一次提交相合并，减少提交数量，并且可以修改提交报文。

​	关于最后三个，就是自动加上了你的 $username$ 和 $email$

​	讲一下提交流程，当你点击提交后，会进入一个 $COMMITE\_EDITMSG$ 窗口，在其中输入你的提交信息，保存关闭即可。

​	**储存：**

​	![image-20240924181542850](https://cdn.luogu.com.cn/upload/image_hosting/f3jkcyvp.png)

​	这个适用于你要切换分支，但是暂存区和工作区还有未提交的文件，可以新建一个储存，将当前状态储存下来，在之后再切换回来。

​	然后这里弹出与应用的区别在于，弹出在应用所选储存的同时也会将对应储存删除。

​	**分支：**

​	![image-20240924221438711](https://cdn.luogu.com.cn/upload/image_hosting/5r9fnlcx.png)

​	分支合并：选择一个分支与当前分支合并

​	基变分支：建议不要用，会打乱提交记录，详情看[Git分支（简介、新建与合并、变基）_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1Pg411z7cq/?spm_id_from=333.337.search-card.all.click&vd_source=7c5af907927ab5070c4787c2f1712d49)

​	创建分支：从当前分支中，创建一个分支

​	从现有来源创建新的分支：是和“创建新分支依据..”一样的，选择一个分支创建一个新分支。

#### 源代码管理

在这里会显示一些在工作区的更改，以及暂存区的情况，还有提交修改按钮

![image-20240924222518316](https://cdn.luogu.com.cn/upload/image_hosting/oig718kr.png)

在最上面“消息”框内输入本次提交的提交信息，当然也可以点击下箭头选择更多的功能。

如果你没往“消息”框中输入信息，那么你会进入一个 $COMMITE\_EDITMSG$ 窗口，在其中输入你的提交信息，保存关闭即可。

Hint：右上角的三个点和在上一节中的功能是一样的。

#### 源代码管理图

![image-20240924222918393](https://cdn.luogu.com.cn/upload/image_hosting/3dawl4xj.png)

在这里，你可以看到当前分支以及其依据分支（就是这个分支从哪里迁出来的）和分支合并的情况，以及这些分支是属于哪里的，本地的还是云端同步的是属于那个分支的（就在右边的小图标）

#### 冲突的解决

分支合并，基变，从远程仓库拉取，同步的时候，会可能出现冲突的情况，只有解决冲突才可以继续下一步。

当合并时会出现一个合并更改，其中有“！”标识的就代表有冲突

![image-20240924225456776](https://cdn.luogu.com.cn/upload/image_hosting/alq0krh6.png)

这个时候打开他，就会看见如下：

![image-20240924225607043](https://cdn.luogu.com.cn/upload/image_hosting/j18b56p8.png)

在左上角提供了一些快捷方式，具体建议自行尝试。如果修改比较复杂，就可以使用右下角的“在合并编辑器中解析”

![image-20240924225847929](https://cdn.luogu.com.cn/upload/image_hosting/vsi17kyj.png)

左右两边就是冲突内容，下面的就是最后合并得到的内容，在左右两个框中提供了一些快捷导入方式，可以自行尝试。

最后点一下“完成合并”就OK啦QWQ

拉取合并同理

#### git on vscode 文件标识

~~其实这个一开始就该讲~~

![image-20240924231113915](https://cdn.luogu.com.cn/upload/image_hosting/zyk9cjxa.png)

|        |                              |
| ------ | ---------------------------- |
| D      | Delete 代表被删除的文件      |
| U      | 代表没有被追踪的文件         |
| M      | Modify 代表有修改的文件      |
| 无标识 | 代表这个文件在仓库里面睡觉觉 |