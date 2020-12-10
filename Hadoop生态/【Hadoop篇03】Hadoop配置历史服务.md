>天空才是你的极限

# Hadoop配置历史服务器

## 应用场景

> 为了查看运行过程序的情况，因此需要配置历史服务器

## 配置步骤

### 1.配置mapred-site.xml

```shell
<!-- 指定历史服务器的IP和端口 -->
<property>
	<name>mapreduce.jobhistory.address</name>
	<value>hadoop102:10020</value>
</property>

<!-- 指定历史服务器Web访问的IP和端口 -->
<property>
    <name>mapreduce.jobhistory.webapp.address</name>
    <value>hadoop102:19888</value>
</property>
```

![image-20200513145557749](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200622091659.png)

### 2.启动历史服务器

```
sbin/mr-jobhistory-daemon.sh start historyserver
```

![image-20200513145709563](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200622091700.png)

### 3.查看历史服务器进程

```
jps命令查看即可
```

### 4.Web端查看

```
# 前提是hosts文件配置了域名映射
http://hadoop102:19888/jobhistory
```

![image-20200513145756522](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200622091701.png)