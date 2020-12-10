> 答应我一次做好一件事情就可以了

## DataNode相关概念

### DataNode工作机制

![image-20200610191819455](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200610191820.png)

1. 一个数据块在DataNode上以**文件形式**存储在磁盘上，包括两个文件，一个是数据本身，一个是元数据包括数据块的长度，块数据的校验和，以及时间戳。
2. DataNode启动后向NameNode注册，通过后，**周期性**（1小时）的向NameNode上报所有的块信息。
3. **心跳**是每3秒一次，心跳返回结果带有NameNode给该DataNode的命令如复制块数据到另一台机器，或删除某个数据块。如果**超过10分钟**没有收到某个DataNode的心跳，则认为该节点不可用。
4. 集群运行中可以安全加入和退出一些机器【后面介绍新增节点和退役节点】。



### 数据完整性

> ​	当DataNode读取Block的时候，它会计算CheckSum。如果计算后的CheckSum，与Block创建时值不一样，说明Block已经损坏。Client读取其他DataNode上的Block。DataNode在其文件创建后周期验证CheckSum，如图所示	

![image-20200610192225007](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200610192227.png)



### 掉线时限参数设置

![image-20200610192341897](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200610192343.png)

在hdfs-site.xml中配置

```shell
<property>
    <name>dfs.namenode.heartbeat.recheck-interval</name>
    <value>300000</value> # 单位毫秒
</property>
<property>
    <name> dfs.heartbeat.interval </name>
    <value>3</value> # 单位秒
</property>
```



### 服役新数据节点

技术背景

>随着公司业务量越来越大，原来的数据节点已经不能满足其存储数据的需求，需要进行节点的动态扩充

如果是使用云服务器就需要在创建一个实例，如果是自己的虚拟机克隆一台就行

下面演示虚拟机克隆来新增节点

1.环境准备

```
（1）在hadoop104主机上再克隆一台hadoop105主机
（2）修改IP地址和主机名称
（3）删除原来HDFS文件系统留存的文件（/opt/module/hadoop-2.7.2/data 和log）
（4）source 一下配置文件: source /etc/profile
```

2.服务节点步骤

```
（1）直接启动DataNode，即可关联到集群,是不是超级简单
[zhutiansama@hadoop105 hadoop-2.7.2]$ sbin/hadoop-daemon.sh start datanode
[zhutiansama@hadoop105 hadoop-2.7.2]$ sbin/yarn-daemon.sh start nodemanager
```

![image-20200610193011503](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200610193013.png)

```
（2）在hadoop105上上传文件
[zhutiansama@hadoop105 hadoop-2.7.2]$ hadoop fs -put /opt/module/hadoop-2.7.2/LICENSE.txt / 
（3）如果数据不均衡，可以用命令实现集群的再平衡
[zhutiansama@hadoop102 sbin]$ ./start-balancer.sh
```



### 退役旧数据节点【白名单】

要点：直接将想要的从机添加到白名单即可

配置白名单步骤如下：

（1）在NameNode的/opt/module/hadoop-2.7.2/etc/hadoop目录下创建dfs.hosts文件

```
[zhutiansama@hadoop102 hadoop]$ pwd
/opt/module/hadoop-2.7.2/etc/hadoop
[zhutiansama@hadoop102 hadoop]$ touch dfs.hosts
[zhutiansama@hadoop102 hadoop]$ vi dfs.hosts
添加如下主机名称（不添加hadoop105）
hadoop102
hadoop103
hadoop104
```

（2）在NameNode的hdfs-site.xml配置文件中增加dfs.hosts属性

```
<property>
<name>dfs.hosts</name>
<value>/opt/module/hadoop-2.7.2/etc/hadoop/dfs.hosts</value>
</property>
```

（3）配置文件分发

```
[zhutiansama@hadoop102 hadoop]$ xsync hdfs-site.xml
```

（4）刷新NameNode

```
[zhutiansama@hadoop102 hadoop-2.7.2]$ hdfs dfsadmin -refreshNodes
```

（5）更新ResourceManager节点

```
[zhutiansama@hadoop102 hadoop-2.7.2]$ yarn rmadmin -refreshNodes
```

（6）在web浏览器上查看

![image-20200610193541480](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200610193543.png)

如果数据不平衡可以再使用start-balancer.sh命令



### 退役旧数据节点【黑名单】

操作同上，只是将白名单文件换位黑名单文件dfs.hosts.exclude

在黑名单上的主机都会被踢出集群



### Datanode多目录配置

这个多目录不是副本的意思，是表明你不想要把所有数据都放在一个目录下罢了

具体配置如下hdfs-site.xml

```
<property>
<name>dfs.datanode.data.dir</name>
<value>file:///${hadoop.tmp.dir}/dfs/data1,file:///${hadoop.tmp.dir}/dfs/data2</value>
</property>
```



