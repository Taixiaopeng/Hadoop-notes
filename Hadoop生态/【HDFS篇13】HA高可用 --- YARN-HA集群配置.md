> 放弃很简单，但坚持一定很酷

# YARN-HA集群配置

### YARN-HA工作机制

1.官方文档

```
http://hadoop.apache.org/docs/r2.7.2/hadoop-yarn/hadoop-yarn-site/ResourceManagerHA.html
```

2.工作机制图

其实就是配置多台RM保证集群高可用，操作和上个文档差不多

![image-20200611192220405](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200611192221.png)

## 配置YARN-HA集群

### 1.环境准备

（1）修改IP

（2）修改主机名及主机名和IP地址的映射

（3）关闭防火墙

（4）ssh免密登录

（5）安装JDK，配置环境变量等

​	（6）配置Zookeeper集群

### 2.	规划集群

本来的RM是在hadoop103，现在在hadoop102也配置一个

| hadoop102       | hadoop103       | hadoop104   |
| --------------- | --------------- | ----------- |
| NameNode        | NameNode        |             |
| JournalNode     | JournalNode     | JournalNode |
| DataNode        | DataNode        | DataNode    |
| ZK              | ZK              | ZK          |
| ResourceManager | ResourceManager |             |
| NodeManager     | NodeManager     | NodeManager |

### 3.具体配置

（1）yarn-site.xml

```
<configuration>

    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>

    <!--启用resourcemanager ha-->
    <property>
        <name>yarn.resourcemanager.ha.enabled</name>
        <value>true</value>
    </property>
 
    <!--声明两台resourcemanager的地址-->
    <property>
        <name>yarn.resourcemanager.cluster-id</name>
        <value>cluster-yarn1</value>
    </property>

    <property>
        <name>yarn.resourcemanager.ha.rm-ids</name>
        <value>rm1,rm2</value>
    </property>

    <property>
        <name>yarn.resourcemanager.hostname.rm1</name>
        <value>hadoop102</value>
    </property>

    <property>
        <name>yarn.resourcemanager.hostname.rm2</name>
        <value>hadoop103</value>
    </property>
 
    <!--指定zookeeper集群的地址--> 
    <property>
        <name>yarn.resourcemanager.zk-address</name>
        <value>hadoop102:2181,hadoop103:2181,hadoop104:2181</value>
    </property>

    <!--启用自动恢复--> 
    <property>
        <name>yarn.resourcemanager.recovery.enabled</name>
        <value>true</value>
    </property>
 
    <!--指定resourcemanager的状态信息存储在zookeeper集群--> 
    <property>
        <name>yarn.resourcemanager.store.class</name>     <value>org.apache.hadoop.yarn.server.resourcemanager.recovery.ZKRMStateStore</value>
</property>

</configuration>
```

（2）同步更新其他节点的配置信息

### 4.启动hdfs 

（1）在各个JournalNode节点上，输入以下命令启动journalnode服务：

```
sbin/hadoop-daemon.sh start journalnode
```

（2）在[nn1]上，对其进行格式化，并启动：

```
bin/hdfs namenode -format

sbin/hadoop-daemon.sh start namenode
```

（3）在[nn2]上，同步nn1的元数据信息：

```
bin/hdfs namenode -bootstrapStandby
```

（4）启动[nn2]：

```
sbin/hadoop-daemon.sh start namenode
```

（5）启动所有DataNode

```
sbin/hadoop-daemons.sh start datanode
```

（6）将[nn1]切换为Active

```
bin/hdfs haadmin -transitionToActive nn1
```

### 5.启动YARN 

（1）在hadoop102中执行：

```
sbin/start-yarn.sh
```

（2）在hadoop103中执行：

```
sbin/yarn-daemon.sh start resourcemanager
```

（3）查看服务状态，如图3-24所示

```
bin/yarn rmadmin -getServiceState rm1
```

![image-20200611192655507](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200611192657.png)







