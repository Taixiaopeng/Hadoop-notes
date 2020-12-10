> 积极乐观的态度是解决任何问题和战胜任何困难的第一步

# Hadoop集群脚本编写

## 编写分发文件脚本

> 应用场景如下：比如有三台主机master1,slave1,slave2
>
> 如果简历完全分布式的集群就需要将文件从master1拷贝到slave从机上
>
> 那么可以使用rsync命令分发单个文件，也可以使用如下脚本分发文件夹或者文件

```shell
#!/bin/bash

#1 获取输入参数个数，如果没有参数，直接退出
# $#代表获得命令行参数个数
pcount=$#
if((pcount==0)); then
echo no args;
exit;
fi

#2 获取文件名称
# $1代表获得命令行第一个参数
p1=$1
fname=`basename $p1`
echo fname=$fname

#3 获取上级目录到绝对路径
pdir=`cd -P $(dirname $p1); pwd`
echo pdir=$pdir

#4 获取当前用户名称
user=`whoami`

#5 rsync命令可以分发文件到指定主机
# 这里slave就是从机的机名
for((host=1; host<3; host++))
do
        echo ------------------- slave$host --------------
        rsync -rvl $pdir/$fname $user@slave$host:$pdir
done

```

## 群起Hadoop集群脚本

> 先在主机上启动HDFS，再去从机启动YARN资源管理器，但是切换麻烦，只想在主机就能解决集群启动问题
>
> 这里演示的是三台服务器，如果是更多台服务器，循环即可【有问题都可以私聊我WX：focusbigdata，或者关注我的公众号：FocusBigData，注意大小写】

```shell
#!/bin/bash

# master1上启动HDFS
/opt/module/hadoop-2.7.2/sbin/start-dfs.sh

# slave1上启动Yarn
ssh slave1 /opt/module/hadoop-2.7.2/sbin/start-yarn.sh

# 这是启动历史服务器
/opt/module/hadoop-2.7.2/sbin/mr-jobhistory-daemon.sh start historyserver
```



## 停止Hadoop集群脚本

```shell
#!/bin/bash

# 关闭历史服务器
/opt/module/hadoop-2.7.2/sbin/mr-jobhistory-daemon.sh stop historyserver

# 关闭YARN
ssh slave1 /opt/module/hadoop-2.7.2/sbin/stop-yarn.sh

# 关闭HDFS
/opt/module/hadoop-2.7.2/sbin/stop-dfs.sh

```

## 查看所有机器的Java进程脚本

> 其实也是用ssh发送命令到每台主机上执行然后返回结果，原理简单而且也很实用

````shell
#!/bin/bash

echo ---------- Master1 --------
/opt/module/jdk1.8.0_131/bin/jps

for((host=1; host<=2; host++));
do
	echo ---------- Slave$host --------
	ssh slave$host /opt/module/jdk1.8.0_131/bin/jps
done
````

## 群起Zookeeper集群脚本

```shell
#!/bin/bash

for((host=102; host<=104; host++));
do
	echo ----------ZK start in $host--------
	ssh hadoop$host /opt/module/zookeeper-3.4.10/bin/zkServer.sh start
done
```

## 停止Zookeeper集群脚本

```shell
#!/bin/bash

for((host=102; host<=104; host++));
do
	echo ----------ZK start in $host--------
	ssh hadoop$host /opt/module/zookeeper-3.4.10/bin/zkServer.sh stop
done
```

## 查看Zookeeper集群状态脚本

```shell
#!/bin/bash

for((host=102; host<=104; host++));
do
	echo ----------ZK start in $host--------
	ssh hadoop$host /opt/module/zookeeper-3.4.10/bin/zkServer.sh status
done
```

## 群起HBase集群脚本

```shell
#!/bin/bash

# 自己的命令也能拿来作为脚本代码哦
/opt/shell/startHadoop.sh
/opt/shell/startZookeeper.sh
echo --------------- HBase Starting  ---------------------
/opt/module/hbase-1.3.1/bin/start-hbase.sh
/opt/shell/j
```

## 停止HBase集群脚本

```shell
#!/bin/bash

echo --------------- HBase Stoping  ---------------------
/opt/module/hbase-1.3.1/bin/stop-hbase.sh
echo --------------- ZK Stoping  ---------------------
/opt/shell/stopZookeeper.sh
echo --------------- Hadoop Stoping  ---------------------
/opt/shell/stopHadoop.sh
/opt/shell/j

```

