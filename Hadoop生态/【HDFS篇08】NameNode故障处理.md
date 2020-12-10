> 记住，你的记忆效率=线索数量*线索质量

## NameNode故障处理

问题场景：只配置了一个NameNode作为主节点，当它宕掉后如何恢复数据呢？

### 方法一：拷贝SNN数据到NN存储数据的目录中

1. kill -9 NameNode进程

2. 删除NameNode存储的数据（/opt/module/hadoop-2.7.2/data/tmp/dfs/name）

```
 rm -rf /opt/module/hadoop-2.7.2/data/tmp/dfs/name/*
```

3. 拷贝SecondaryNameNode中数据到原NameNode存储数据目录

```
 在hadoop102上执行，拷贝hadoop104的数据到这里
 
 scp -r 用户名@hadoop104:/opt/module/hadoop-2.7.2/data/tmp/dfs/namesecondary/* ./name/
```

4. 重新启动NameNode即可

```
hadoop-daemon.sh start namenode
```



### 方法二：使用-importCheckpoint选项启动NN守护进程，它会将SNN数据拷贝到NN数据目录中的

1. 修改hdfs-site.xml

```xml
<property>
 <name>dfs.namenode.checkpoint.period</name>
 <value>120</value>
</property>

<property>
 <name>dfs.namenode.name.dir</name>
 <value>/opt/module/hadoop-2.7.2/data/tmp/dfs/name</value>
</property>
```

2. kill -9 NameNode进程
3. 删除NameNode存储的数据（/opt/module/hadoop-2.7.2/data/tmp/dfs/name）

```
rm -rf /opt/module/hadoop-2.7.2/data/tmp/dfs/name/*
```

4.	拷贝SecondaryNameNode中数据到原NameNode存储数据目录并删除in_use.lock文件

```
scp -r 用户名@hadoop104:/opt/module/hadoop-2.7.2/data/tmp/dfs/namesecondary ./

[zhutiansama@hadoop102 namesecondary]$ rm -rf in_use.lock
```

5.	导入检查点数据（等待一会ctrl+c结束掉）

```
hdfs namenode -importCheckpoint
```

​	6.启动NameNode

```
hadoop-daemon.sh start namenode
```

