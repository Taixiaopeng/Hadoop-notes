1. Maven        自动化构建项目的工具
2. linux        操作系统
3. shell编程     脚本编程 一门语言规则
4. Hadoop        
         -------- 入门(轻松搭建集群)
         ---------HDFS (分布式文件存储系统)--> 数据的存储
         -------- MapReduce (数据的计算和分析)
         --------- Yarn 
                        运行计算程序的平台
1. Maven

概述:
    自动化构建项目的工具
    为什么要使用 Maven
    Maven是什么
    如何使用 Maven
    Maven核心概念
    继承
    聚合
    通过 Maven搭建Web工程
    Maven酷站

1.目前的技术在开发中存在的问题
    借助于Maven可以将一个项目拆分成多个工程 便于分工和管理
    项目中jar包必须手动复制,粘贴,工程会很臃肿,借助maven可以将jar包只保存在仓库里,在有需要使用的项目中引用即可
    突出的Maven官方提供了大量的jar包
    借助maven可以以一种统一的规范下载jar包,内容可靠.
2. 什么是maven
    Maven是一款服务于java平台的自动化构建工具
    Make-->Ant-->Maven-->Gradle
    2.1 构建过程中的各个环节
        清理 
        编译
        测试
        报告
        打包
        安装
        部署
3. 第三方Jar包添加
    Maven后每个jar包只在本地仓库中保存一份
    Maven本地仓库 存储下载好的jar包
    Maven会从仓库自动下载这个jar包所依赖的其他jar包
    Maven内置规则
    ① 路径最短者优先
    ② 先声明者优先
4. Maven的使用
4.1 Maven的核心概念

        POM 
        约定的目录结构
        坐标
        依赖
        仓库
        生命周期 
        插件
        目标 
        继承 
        聚合
4.2 第一个Maven工程         约定>配置>编码
    ①创建约定的目录结构
        根目录:工程名
        src目录:源码
        pro.xml文件:Maven工程的核心配置文件
        main目录:存放主程序
        test目录:存放测试程序
        java目录:存放java源文件
        resources目录:存放框架或其他工具的配置文件
    ②为什么还要遵守约定的目录结构
        maven需要知道我们的相关源文件放在什么地方
   ③自定义的东西让框架或者工具知道
        以配置的方式告诉框架
        遵守框架内部已经存在的约定 
4.3 常用的Maven命令
    ①注意:执行与构建过程相关的Maven命令,必须进入pom.xml所在的目录.
    ②常用的命令:
        mvn clean
        mvn compile
        mvn test-compile
        mvn test
        mvn package
        mvn install
        mvn site
4.4 关于maven]联网的问题
    maven的核心程序仅仅定义了抽象的生命周期,但是具体的工作需要特定的插件来完成,而插件不在maven程序中
    maven的核心程序优先在本地仓库中查找,之后去中央仓库下载    

5.1 POM
    Project Object Model 项目对象模型.将Java工程的相关信息封装为对象作为便于操作和管理的模型.
学习maven,即学习 POM.xml中的配置

5.2 约定的目录结构
约定>配置>编码

5.3 坐标
使用以下三个向量在Maven中唯一确定一个Maven工程.
gropId     公司或组织的域名倒序+当前项目名称
artifactId 当前项目的模块名称
version    当前模块的版本
在项目的pom.xml文件中存储坐标

<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.atguigu.maven</groupId>   

    <artifactId>Hello</artifactId>

    <version>1.0-SNAPSHOT</version>
</project>

5.4 仓库
    ①仓库的分类
        本地仓库
        远程仓库
            私服
            中央仓库
            中央仓库的镜像
        仓库中的内容: Maven工程
            ① Maven自身所需要的插件
            ② 第三方框架或工具jar包

6 依赖(初步)
    ①Maven解析依赖信息时会到本地仓库中查找被依赖的jar包.
        对于我们自己开发的maven工程,使用 mvn install就可以进入仓库
    ②依赖的范围
            compile  test  provide
主程序         Y                Y
测试程序       Y        Y       Y
是否参与打包    Y
是否参与部署    Y        

7. 依赖管理
    ①基本概念
    直接依赖
    简介依赖
    坐标:
    --groupId
    --artifactId
    --version
    模块与模块之间是可以相互依赖的
    依赖的范围
        scope标签的设置
            --compile(默认)
            --test
            --provide
8.1 依赖的传递性
8.2 依赖的原则
    --路径最短者优先
    --路径相同的情况下,先声明者优先
8.3 依赖的排除
8.4 单个模块中Jar包的版本管理
    -- propertise标签
     -- 自定义标签
            --${自定义标签的名称}


9. 生命周期
    ① 各个构建环节执行顺序必须顺序执行
    ② maven的核心程序定义了抽象的生命周期,生命周期中的各个阶段的具体任务是由插件来完成的
    ③ maven的核心程为了更好的实现自动化构建,按照这一特点执行生命周期的各个阶段:不论现在要执行生命周期的哪儿一个阶段,都是从这个生命周期最开始的位置开始执行
     mvn compile mvn test mvn package
     插件和目标
        ①生命周期的各个阶段仅仅是定义了要执行的任务是什么
        ②各个阶段和插件的目标是相对应的
        ③相似的目标由特定的插件来完成
            ③ 我们自己开发的maven工程.

10.插件和目标
11.继承
   --创建父工程(pom打包)
   --子工程,声明父工程的坐标和路径
   --

12.聚合









    