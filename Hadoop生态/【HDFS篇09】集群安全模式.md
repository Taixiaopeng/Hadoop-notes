> 一个微小的投入就会带来巨大的突变

## 集群安全模式

### 为什么出现集群安全模式呢？

>​	Namenode启动时，首先将镜像文件载人内存，并执行编辑日志中的各项操作。一旦在內存中成功建立文件系统元数据的映像，则创建一个新的Fsimage文件和一个空的编辑日志。此时，** Namenode开始监听Datanode请求**。这个过程期间， Namenode一直运行在安全模式，即NameNode的文件系统对于客户端来说是只读的

其实安全模式就是集群数据都还没准备好时候的一个保护机制



### DataNode启动发生的事情

>​	系统中的数据块的位置并不是由 NameNode维护的，**而是以块列表的形式存储在 DataNode中**。在系统的正常操作期间， NameNode会在内存中保留所有块位置的映射信息。在安全模式下，各个 DataNode会向NameNode发送最新的块列表信息， NameNode了解到**足够多**的块位置信息之后，即可髙效运行文件系统

这个足够多是多少呢？99.9%



### 安全模式退出的判断

>**如果满足“最小副本条件”， NameNode会在30秒钟之后就退出安全模式**。所谓的最小副本条件指的是在整个文件系统中99.9%的块满足最小副本级别（默认值：dfs.replication.min=1）。在启动一个刚刚格式化的HDFS集群时，因为系统中还没有任何块，所以 Namenode不会进入安全模式。



### 集群安全模式下的操作

- hdfs dfsadmin -safemode get		（功能描述：查看安全模式状态）
- hdfs dfsadmin -safemode enter  （功能描述：进入安全模式状态）
- hdfs dfsadmin -safemode leave	（功能描述：离开安全模式状态）
- hdfs dfsadmin -safemode wait	（功能描述：等待安全模式状态）

