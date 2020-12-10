> 可以慢，但不要停

# Yarn任务推测执行

## 任务的推测执行

### 1．作业完成时间取决于最慢的任务完成时间

> 一个作业由若干个Map任务和Reduce任务构成。因硬件老化、软件Bug等，某些任务可能运行非常慢。

典型案例：系统中有99%的Map任务都完成了，只有少数几个Map老是进度很慢，完不成，怎么办？

### 2．推测执行机制

> ​	发现拖后腿的任务，比如某个任务运行速度远慢于任务平均速度。为拖后腿任务启动一个备份任务，同时运行。谁先运行完，则采用谁的结果。

### 3．执行推测任务的前提条件

```
（1）每个Task只能有一个备份任务；
（2）当前Job已完成的Task必须不小于0.05（5%）
（3）开启推测执行参数设置。Hadoop2.7.2 mapred-site.xml文件中默认是打开的。
```

```xml
# mapred-site.xml
<property>
  	<name>mapreduce.map.speculative</name>
  	<value>true</value>
  	<description>If true, then multiple instances of some map tasks may be executed in parallel.</description>
</property>

<property>
  	<name>mapreduce.reduce.speculative</name>
  	<value>true</value>
  	<description>If true, then multiple instances of some reduce tasks may be executed in parallel.</description>
</property>
```

### 4．不能启用推测执行机制情况

```
（1）任务间存在严重的负载倾斜；
（2）特殊任务，比如任务向数据库中写数据
```

### 5.推测执行算法原理

![image-20200621161200491](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621161201.png)