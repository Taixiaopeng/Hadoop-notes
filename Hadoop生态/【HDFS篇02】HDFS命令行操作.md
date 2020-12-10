> 完成永远比完美重要

## HDFS的Shell操作

## 基本语法

1. hadoop fs 具体命令【推荐】
2. hdfs dfs 具体命令

### 常用命令大全

+ 启动Hadoop集群

```
// 这些命令也都可以按照自己的方式组成脚本哦
start-dfs.sh
start-yarn.sh
```

+ -help：输出这个命令参数

```
hadoop fs -help rm
```

![image-20200514155606611](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514155606611.png)

+ -ls: 显示目录信息

```
 hadoop fs -ls /
 hadoop fs -ls -R / 递归查看
```

![image-20200514155635893](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514155635893.png)

+ -mkdir：在HDFS上创建目录

```
hadoop fs -mkdir -p /input/word_data
```

![image-20200514155854600](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514155854600.png)

+ -moveFromLocal：从本地剪切粘贴到HDFS

```
touch new_data.txt 创建文件
hadoop fs  -moveFromLocal  ./new_data.txt  /input/
```

![image-20200514160045554](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514160045554.png)

+ -appendToFile：追加一个文件到已经存在的文件末尾

```
echo "hello xiaofei" >> xiaofei.txt
hadoop fs -appendToFile ./xiaofei.txt /input/new_data.txt
```

![image-20200514160328141](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514160328141.png)

+ -cat：显示文件内容

```
hadoop fs -cat /input/new_data.txt
```

看上图

+ -chgrp 、-chmod、-chown：Linux文件系统中的用法一样，修改文件所属权限

```
hadoop fs  -chmod  777 /input
hadoop fs  -chown  zhutian:zhutian /input
```

![image-20200514160434308](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514160434308.png)

+ -copyFromLocal：从本地文件系统中拷贝文件到HDFS路径去

```
hadoop fs -copyFromLocal ./xiaofei.txt /input
```

![image-20200514160658156](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514160658156.png)

+ -copyToLocal：从HDFS拷贝到本地

```
hadoop fs -copyToLocal /input/xiaofei.txt ./
```

演示略

+ -cp ：从HDFS的一个路径拷贝到HDFS的另一个路径

```
hadoop fs -cp /input/xiaofei.txt /output/xiaofei
```

![image-20200514160838280](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514160838280.png)

+ -mv：在HDFS目录中移动文件

```
hadoop fs -mv /input/new_data.txt /output/new_data.txt
```

![image-20200514160936911](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514160936911.png)

+ -get：等同于copyToLocal，就是从HDFS下载文件到本地

```
hadoop fs -get /input/xiaofei.txt ./
```

![image-20200514161015493](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514161015493.png)

+ -getmerge：合并下载多个文件，比如HDFS的目录 /aaa/下有多个文件:log.1, log.2,log.3,...

```
hadoop fs -getmerge /input/* ./together.txt
```

![image-20200514161214830](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514161214830.png)



+ -put：等同于copyFromLocal

```
hadoop fs -put ./together.txt /input
```

![image-20200514163219743](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514163219743.png)

+ -tail：显示一个文件的末尾

```
 hadoop fs -tail /input/xiaofei.txt
```

![image-20200514163232018](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514163232018.png)

+ -rm：删除文件或文件夹

```
hadoop fs -rm /output/new_data.txt
```

![image-20200514163319206](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514163319206.png)

+ -rmdir：删除空目录

```
hadoop fs -mkdir /test
```

+ -du统计文件夹的大小信息

```
hadoop fs -du  -h /input/xiaofei.txt
```

![image-20200514163402913](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514163402913.png)

+ -setrep：设置HDFS中文件的副本数量

```
hadoop fs -setrep 10 /input/xiaofei.txt
```

![image-20200514163522898](C:\Users\ZYT\AppData\Roaming\Typora\typora-user-images\image-20200514163522898.png)

> ​	这里设置的副本数只是记录在NameNode的元数据中，是否真的会有这么多副本，还得看DataNode的数量。因为目前只有3台设备，最多也就3个副本，只有节点数的增加到10台时，副本数才能达到10。