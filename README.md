# 安装Windows后要做的事

## 激活并备份激活文件

```
C:\Windows/System32/spp/store 
```

## 调整安全性和个性化设置 


个性
1. 设置“此电脑”和“控制面板”在桌面显示
1. 不在任务栏显示搜索
1. 设置任务栏为小图标
1. 设置任务栏图标永不合并
1. 不在任务栏显示新闻和兴趣
1. 设置显示隐藏文件
1. 设置显示文件后缀
1. 设置 Explorer 的视图都使用列表
1. 设置浅色主题
1. 设置主题颜色为蓝色
1. 设置窗口标题栏跟随主题颜色
1. 文本光标粗细2
1. 鼠标大小2
1. 鼠标滚轮滚动行数5
1. 开始菜单更多磁贴
1. 性能设置中关掉一些动画特效
1. 设置系统为不检测代理
1. 修改电源设置，不自动关闭显示器，不自动睡眠，禁用休眠，禁用快速启动
1. 关游戏模式、关xbox game bar

安全
1. 禁用所有媒体、磁盘、介质的自动播放
1. 删除文件需要确认
1. 不允许远程协助
1. Server服务由自动启动改为手动

隐私
1. 关闭所有能关闭的统计、遥测、广告ID（“量身定制的体验”）
1. 设置不跟踪应用启动
1. 禁用所有云同步
1. 关闭云内容搜索
1. 关闭储存此设备搜索记录
1. 关闭所有拼写检查、输入建议、智能输入、智能标点
1. 关在线语音识别
1. 诊断：只发必须的诊断
1. 反馈频率：从不
1. 不在此设备储存活动历史
1. 不允许应用进行：定位、语音激活、电话、日历、联系人、访问通知、任务消息、后台运行



## 做C盘分区备份前减小C盘占用

### 删掉不需要的自带程序

使用PowerShell

```shell
Get-AppxPackages -allusers
Get-AppxProvisionedPackage -online | select name, packagefullname
```

然后对照着包名进行

```shell
Remove-AppxPackage -allusers <packagename>
Remove-AppxProvisionedPackage -online -packagefullname <packagefullname> 
```



### 去掉hiberfil.sys

`C:/hibertfil.sys`这个文件有好几G，是休眠用的。

使用管理员执行

```
powercfg -h off
```

### 适当减小pagefiles.sys

`C:/pagefiles.sys`大小可以设置。

性能设置高级里。

### 清理旧驱动

使用一个软件删掉旧的驱动（显卡驱动一般不小）

https://github.com/lostindark/DriverStoreExplorer


### 其他临时文件

如果做C盘的备份镜像，可以先删掉以下文件再镜像

```
c:/pagefiles.sys
c:/hibertfil.sys
c:/swapfile.sys 
C:/Windows/winsxs/Backup
C:\Windows\Temp\
C:\Windows\System32\Logfiles\ 
C:\Windows\SoftwareDistribution\Download\
C:\Windows\Prefetch
C:\Windows\DriverCache
C:\Windows\system32\dllcache
C:\Windows\lastgood.tmp
C:\User\用户名\LocalSettings\Temp\
```
