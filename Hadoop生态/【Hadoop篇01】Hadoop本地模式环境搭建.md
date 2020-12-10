>生命中真正重要的不是你遭遇了什么，而是你记住了哪些事，又是如何铭记的

# Hadoop本地模式环境搭建

# 一.准备虚拟机环境

## 	（1）克隆虚拟机
	使用VMware克隆三台虚拟机
##	（2）修改主机名

```
vim /etc/hosts
```

##	（3）配置IP为静态IP

```
ifconfig
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325205001943.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMxOTIzODcx,size_16,color_FFFFFF,t_70)

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325205054483.png)![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325205121713.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMxOTIzODcx,size_16,color_FFFFFF,t_70)

## 	（4）配置ip和域名之间的映射
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325205336528.png)![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325205404574.png)
## 	（5）创建用户, 并设置密码
```
useradd zhutiansama
passwd 123456
```

## （6）给用户配置具有root权限
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325205834751.png)

```
root	ALL=(ALL)	ALL
zhutiansama	ALL=(ALL)	ALL
```

## （7）关闭防火墙
```
sudo chkconfig iptables off
```

## （8）在/opt目录下创建文件夹
```
mkdir /opt/module
```



# 二.安装jdk
## （1）使用ftp工具将jdk安装包导入到/opt/software目录下
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325210813583.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMxOTIzODcx,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325210823715.png)
## （2）解压jdk到/opt/module目录下
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325210926876.png)
## （3）配置jdk环境变量
打开etc/profile文件, 在文件末尾加入如下两行:
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019032521095116.png)修改后的文件生效
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325211010759.png)测试JDK是否安装成功
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325211022702.png)

# 三. 安装Hadoop
## （1）把Hadoop安装包传递到/opt/software

## （2）解压到module下
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325211207916.png)

## （3）配置Hadoop环境变量
打开/etc/profile文件, 末尾添加两行代码:![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325211235561.png)使用文件生效：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325211325914.png)测试是否配置成功
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190325211338470.png)