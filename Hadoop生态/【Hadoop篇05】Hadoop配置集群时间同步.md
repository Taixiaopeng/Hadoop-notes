> 做任何事都要经受得挫折，要有恒心和毅力，满怀信心坚持到底

# Hadoop配置集群事件同步

## 时间同步方式

> 找一台机器，作为时间服务器，所有的机器与这台集群时间进行定时的同步，比如，每隔十分钟，同步一次时间

## 配置时间同步步骤

### 1.时间服务器配置（必须root用户）

```
rpm -qa|grep ntp
```

![image-20200513152600904](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200622092009.png)

### 2.修改ntp配置文件

```
vi /etc/ntp.conf

修改内容如下
a）修改1（授权192.168.1.0网段上的所有机器可以从这台机器上查询和同步时间）
打开限制
#restrict 192.168.1.0 mask 255.255.255.0 nomodify notrap为
restrict 192.168.1.0 mask 255.255.255.0 nomodify notrap

b）修改2（集群在局域网中，不使用其他的网络时间）
server 0.centos.pool.ntp.org iburst
server 1.centos.pool.ntp.org iburst
server 2.centos.pool.ntp.org iburst
server 3.centos.pool.ntp.org iburst为
#server 0.centos.pool.ntp.org iburst
#server 1.centos.pool.ntp.org iburst
#server 2.centos.pool.ntp.org iburst
#server 3.centos.pool.ntp.org iburst

c）添加3（当该节点丢失网络连接，依然可以作为时间服务器为集群中的其他节点提供时间同步）
server 127.127.1.0
fudge 127.127.1.0 stratum 10
```

### 3.修改/etc/sysconfig/ntpd 文件

```
vim /etc/sysconfig/ntpd

增加内容如下（让硬件时间与系统时间一起同步）
SYNC_HWCLOCK=yes
```

### 4.重新启动ntpd

```
service ntpd status
service ntpd start
```

### 5.加入配置项

```
chkconfig ntpd on
```

### 6.其他机器配置（必须root用户）

（1） 编写定时任务10分钟和主时间服务器同步一次

```
crontab -e
编写定时任务如下：
*/10 * * * * /usr/sbin/ntpdate hadoop102
```

（2）修改任意时间

```
date -s "2017-9-11 11:11:11"
```

（3）十分钟后查看是否同步成功

```
date
```



