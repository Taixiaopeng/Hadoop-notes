> 生于忧患，死于安乐

# Flink集群部署

## Standlone模式

### （1）修改 flink/conf/flink-conf.yaml 文件

![image-20200621094356188](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621094356.png)

### （2）修改 /conf/slaves文件

![image-20200621094454035](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621094455.png)

> 听说以后master/slaves都不能用了，你懂我的意思吧

### （3）分发给另外两台机子

![image-20200621094621748](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621094624.png)

### （4）启动

![image-20200621094705534](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621094706.png)

### （5）访问Web界面

![image-20200621094749875](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621094750.png)

### （6）任务提交到集群

+ 准备好数据文件

![img](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621094835.jpg)

+ 数据文件分发到每台taskmanager中(由于读取数据是从本地磁盘读取，实际任务会被分发到taskmanage的机器中，所以要把目标文件分发。)

```
xsync data.txt
```

+ 在集群执行程序

```
/flink run -c com.zhutian.wc.StreamWordCount –p 2 FlinkTutorial-1.0-SNAPSHOT-jar-with-dependencies.jar --host localhost–port 7777
```

+ 然后就可以去Web控制台查看结果了

> 也可以通过Web界面提交任务哦



## Yarn模式

> ​	以Yarn模式部署Flink任务时，要求Flink是有Hadoop支持的版本，**Hadoop环境需要保证版本在2.2以上**，并且集群中安装有HDFS服务。

### 1.Session-cluster模式

![img](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621095219.jpg)

​	Session-Cluster模式需要先启动集群，然后再提交作业，接着会向yarn申请一块空间后，**资源永远保持不变**。如果资源满了，下一个作业就无法提交，只能等到yarn中的其中一个作业执行完成后，释放了资源，下个作业才会正常提交。**所有作业共享Dispatcher和ResourceManager**；共享资源；适合规模小执行时间短的作业。

​	在yarn中初始化一个flink集群，开辟指定的资源，以后提交任务都向这里提交。这个flink集群会常驻在yarn集群中，除非手工停止。

### 2.Per-Job-Cluster模式

![img](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621095344.jpg)

​	**一个Job会对应一个集群**，每提交一个作业会根据自身的情况，都会**单独向yarn申请资源**，直到作业执行完成，**一个作业的失败**与否并不会影响下一个作业的正常提交和运行。独享Dispatcher和ResourceManager，按需接受资源申请；适合规模大长时间运行的作业。

​	每次提交都会创建一个新的flink集群，任务之间互相独立，互不影响，方便管理。任务执行完成之后创建的集群也会消失。

### SessionCluster部署

### （1）启动Hadoop集群

> startHadoop.sh和j都是我自己写的脚本，【有问题都可以私聊我WX：focusbigdata，或者关注我的公众号：FocusBigData，注意大小写】

![image-20200621095659163](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621095700.png)

### （2）启动yarn-session

![image-20200621100228574](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621100229.png)

> 报错了，有点慌，这个提示很猜想到少了依赖包，注意版本，拷贝到lib目录下即可

![image-20200621100350246](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621100351.png)

![image-20200621100521995](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621100522.png)

### （3）执行任务

```
./flink run -c com.zhutian.wc.StreamWordCount  FlinkTutorial-1.0-SNAPSHOT-jar-with-dependencies.jar --host localhost –port 7777
```

### （4）去yarn控制台查看任务状态

![image-20200621100642113](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621100642.png)

### （5）只能手动取消flink集群

![image-20200621100906057](https://gitee.com/zhutiansama/MDPictureResitory/raw/master/img/20200621100906.png)

>集群启动的时候，会有上面如何停止它的命令



### Per-Job-Clusterb部署

### （1）启动Hadoop集群

### （2）不启动yarn-session，直接执行job

```
/flink run –m yarn-cluster -c com.zhutian.wc.StreamWordCount  FlinkTutorial-1.0-SNAPSHOT-jar-with-dependencies.jar --host localhost –port 7777
```

## K8s部署

> ​	了解就行，不需要自己操作，公司运维都会替你搭好。容器化部署时目前业界很流行的一项技术，基于Docker镜像运行能够让用户更加方便地对应用进行管理和运维。容器管理工具中最为流行的就是Kubernetes（k8s），而Flink也在最近的版本中支持了k8s部署模式。

（1）搭建Kubernetes集群（略）
（2）配置各组件的yaml文件
	在k8s上构建Flink Session Cluster，需要将Flink集群的组件对应的docker镜像分别在k8s上启动，包括JobManager、TaskManager、JobManagerService三个镜像服务。每个镜像服务都可以从中央镜像仓库中获取。
（3）启动Flink Session Cluster

```
// 启动jobmanager-service 服务
kubectl create -f jobmanager-service.yaml
// 启动jobmanager-deployment服务
kubectl create -f jobmanager-deployment.yaml
// 启动taskmanager-deployment服务
kubectl create -f taskmanager-deployment.yaml
```

（4）访问Flink UI页面
集群启动后，就可以通过JobManagerServicers中配置的WebUI端口，用浏览器输入以下url来访问Flink UI页面了

```
http://{JobManagerHost:Port}/api/v1/namespaces/default/services/flink-jobmanager:ui/proxy
```



