> ​	成长这一路就是懂得闭嘴努力，知道低调谦逊，学会强大自己，在每一个值得珍惜的日子里，拼命去成为自己想成为的人

# Hadoop配置日志聚集

## 应用场景

> 为了让应用运行完成以后，将程序运行日志信息上传到HDFS系统上，有了日志之后就可以查看程序中的报错信息，从而调试程序

## 配置步骤

### 1.配置yarn-site.xml

```shell
<!-- 日志聚集功能使能 -->
<property>
	<name>yarn.log-aggregation-enable</name>
	<value>true</value>
</property>

<!-- 日志保留时间设置7天 -->
<property>
	<name>yarn.log-aggregation.retain-seconds</name>
	<value>604800</value>
</property>
```

![image-20200513145915443](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200623153146.png)

### 2.重启集群

```
sbin/stop-yarn.sh
sbin/stop-dfs.sh
sbin/mr-jobhistory-daemon.sh stop historyserver

sbin/start-dfs.sh
sbin/start-yarn.sh
sbin/mr-jobhistory-daemon.sh start historyserver
```

### 3.运行程序

上传数据到HDFS

![image-20200513151302613](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200623153147.png)

赋给文件权限

![image-20200513151510631](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200623153148.png)

运行程序

![image-20200513151752877](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200623153149.png)

查看运行结果

![image-20200513151910293](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200623153150.png)

### 4.查看日志

![image-20200513152037521](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200623153151.png)

![image-20200513152052182](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200623153152.png)

![image-20200513152144855](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200623153153.png)