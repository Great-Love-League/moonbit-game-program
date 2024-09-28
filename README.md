# 打飞机

## 游戏基础规划

### Step1 传统飞机大战（横板）

#### 关卡背景

为方便分辨飞机与背景,暂定为纯黑色背景
初稿完成后可以考虑使用静态或者动态背景完成

#### 关卡界面(UI)

##### ``顶部遮罩信息栏`` 弃用,因显示像素有限

##### 底部透明信息栏

左侧(暂定x:3-28,y:142-157)显示玩家HP, 右侧(暂定x:110-148,y:142-157)显示该玩家该回合当前用时(格式hh:mm:ss)

#### 飞机类型

##### 自机

**移动范围限制在自机中心点必须处于显示像素(160x160)的范围内**

1. 规格 :

    9x13像素

    100HP

    移动速度(暂定) 30像素/s

    *操作方式: (当自机数量为1时)输入 w/上方向键 向上移动, 输入 s/下方向键 向下移动, 输入 a/左方向键 向左移动, 输入 d/右方向键 向右移动*

    *操作方式: (当自机数量为2时)输入 wasd控制player1的移动, 输入 ←↑↓→控制player2的移动*

    ``慢速移动(暂定按住shift键) 10像素/s``(初稿不考虑 2期工程)

2. 功能 :

    发射各类子弹,初始子弹为单行普通子弹

    获得自身附近(暂定以自机几何中心点为中心的18x18像素的矩形范围内)的特殊道具包

3. 数量 :

    1个(对于一个玩家)

    2个(对于两个玩家)

##### 敌机

除由*特殊大型机*生成的自杀式小型机外, 所有敌机均随机生成在屏幕顶端像素(及敌机头部第一个像素处于显示像素的最上端), 向下做匀速运动直到其HP==0或者全部像素移动至显示区域(160x160)外

**敌机生成位置的范围需保证其边缘像素离左右两侧边显示像素的距离大于等于5像素**

###### 小型机

1. 规格 :

    4x4像素

    10HP

    移动速度(暂定) 40像素/s

2. 功能 :

    不发射子弹,充当障碍物,与自机相撞后爆炸并造成伤害(20 DD)

    ``部分充当自杀式飞向自机(仅限特殊大型机发射的小型机)(20 DD)``(初稿不考虑 2期工程)

###### 中型机

1. 规格 :

    7x11像素

    40 HP

    移动速度(暂定) 25像素/s

2. 功能 :

    发射单行普通子弹(10 DPS)射向屏幕下方

###### 大型机

1. 规格 :

    21x21像素

    100 HP

    移动速度(暂定) 15像素/s

2. 功能 :

    发射双行普通子弹(20 DPS)

###### ``特殊大型机(定时/随机BOSS)``(初稿不考虑 2期工程)

1. 规格 :

    21x21像素

    200 HP

    移动速度(暂定) 10像素/s

2. 功能 :

    发射双行普通子弹(20 DPS)

    放出自杀式小型机(20 DD)

#### 子弹类型

##### 普通子弹

1x2像素

子弹速度10发/秒

这种子弹无任何特殊效果,发射后径直向屏幕上方飞出,接触敌机后造成 10 伤害/(秒x子弹行数)

##### 高爆子弹

1x2像素

子弹速度10发/秒

这种子弹发射后径直向屏幕上方飞出,接触敌机后造成 20 伤害/(秒x子弹行数),即为普通子弹伤害的两倍

##### ``追踪型子弹``(初稿不考虑 2期工程)

1x1像素

子弹速度10发/秒

这种子弹发射后追踪离自机最近的敌机,接触敌机后造成 10 伤害/(秒x子弹行数)

##### 激光束子弹

2x∞像素(竖向从自机前端到显示区域为止)

子弹速度N/A(连续)

这种子弹发射后径直向屏幕上方飞出,接触敌机后造成 10 伤害/(秒x子弹行数),即为普通子弹伤害的两倍

#### 特殊道具包

##### 高爆子弹包

    8x8像素

    每间隔一段时间(暂定30s-60s)随机出现在顶端并以30像素/s的速度下落

    仅自机可以获得

    作用效果: 自机获得后将在10s内将原有组数的任意种类子弹伤害*2

##### 双倍子弹包

    8x8像素

    每间隔一段时间(暂定20s-60s)随机出现在顶端并以30像素/s的速度下落

    仅自机可以获得

    作用效果: 自机获得后将在10s内将任意组数的任意种类子弹 变为 2组子弹

##### ``激光束子弹包``(初稿不考虑 2期工程)

    8x8像素

    每间隔一段时间(暂定45s-90s)随机出现在顶端并以30像素/s的速度下落

    仅自机可以获得

    作用效果: 自机获得后将在10s内将原有组数的任意种类子弹变为激光束子弹

##### ``追踪子弹包``(初稿不考虑 2期工程)

    8x8像素

    每间隔一段时间(暂定60s-90s)随机出现在顶端并以30像素/s的速度下落

    仅自机可以获得

    作用效果: 自机获得后的10s内,其原有组数的任意种类子弹将自动追踪离自机最近的敌机,造成的伤害视情况而定

    **若自机当前子弹伤害高于追踪子弹伤害(10 DPS),则自机子弹伤害不变**

    **若自机当前子弹伤害低于追踪子弹伤害(10 DPS),则自机子弹伤害变为10 伤害/(秒x子弹行数)

##### ``清屏炸弹包``(初稿不考虑 2期工程)

    8x8像素

    每间隔一段时间(暂定120s-150s)随机出现在顶端并以30像素/s的速度下落

    仅自机可以获得 
    
    作用效果: 自机获得后将已经产生的敌机全部清除, 包括其产生的子弹, 并在3s内不再产生新敌机

##### 血量恢复包

    8x8像素

    每间隔一段时间(暂定60s-120s)随机出现在顶端并以30像素/s的速度下落

    仅自机可以获得 
    
    作用效果: 自机获得后将把HP恢复至100

### Step2 PVE 1V1对决(类似与几何决斗)

### Step3 PVP 1V1对决(类似与几何决斗)