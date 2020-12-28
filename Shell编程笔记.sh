Shell编程
1.1shell概述
    shell是一个命令行解释器,它是接收应用程序的/用户的命令,然后调用操作系统内核
    shell是一个编程语言
1.2关于shell
    Linux提供的Shell解析器:cat /etc/shells
            /bin/sh   
            /bin/bash
            /usr/bin/sh
            /usr/bin/bash
            /bin/zsh
    bash和sh的关系
            --ll |grep bash 
    Centos默认解释器
            --echo $SHELL
2.Shell脚本入门
        2.1 第一个脚本
                #!/bin/bash
                echo "HelloWorld"
        2.2 解释
                 #!/bin/bash   指定脚本解释器使用的bash
                 echo --向控制台打印输出
           
3. 变量
        3.1 系统变量
        3.2 环境变量


9.SHELL工具
  9.1 cut命令
        含义:从文件中的每一行剪切字节 字符和字段并将这些字节和字段输出
        cut[选项参数] filename
        说明:默认分隔符是制表符
        选项参数说明:
                -f 列号,提取第几列
                -d 分隔符.按照指定分隔符分隔列
                -c 指定具体的字符
  9.2 awk命令
        含义:把文件逐行读入,以空格为默认分隔符将每行切片,切开的部分再进行分析处理
        基本用法:
         --awk[选项参数] 'pattern1{acyion} pattern2{action}...' filename
                --patten 表示AWK在数据中查找的内容,就是匹配模式
                --action 找到匹配的内容时执行一系列命令
         选项参数说明
                 -F 指定输入文件拆分隔符
                 -v 赋值一个用户定义变量
         AWK的内置变量
                FILENAME 文件名
                NR 已读的记录数 --行号
                NF 浏览记录的域的个数(切割后,;列的个数)