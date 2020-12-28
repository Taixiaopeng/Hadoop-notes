Linux发展史
    GNU 自由软件发展基金会
    Posxi标准
    开源免费的内核
 Shell
 1.什么是shell   贝壳
    cat /etc/shells 查看当前系统全部的shell
    echo $SHELL 查看正在使用的shell
    脚本解释器
    Table键补全
    ctrl+l 清屏
    Ctrl+a 光标到最前
    Ctrl+e 光标到最后
    tty终端


2. 分区和目录
    主分区   primary partion
    扩展分区  extension partion
    主分区+扩展分区不能超过四个,但并不是说明Linux下只能分四个区
    主分区可以直接使用,扩展分区必须经过第二次分区才能使用(逻辑分区logical )
    逻辑分区没有数量限制
    2.1 磁盘文件
            查看设备名 sudo fdisk -l
            主分区从sda1到sda4
            /dev/sda1
            /dev/sda2
            /dev/sda3
            /dev/sda4
            逻辑分区永远从sda5开始
        sda1 sda2  sda3 sda5  sda6  
        主     主   扩   逻辑   逻辑 
    2.2 目录结构

        . 当前目录
        .. 上级目录
        ~ 家目录 echo $home
3. 文件管理
    3.1 ls 命令
        文件 = 文件内容  + 文件属性
        文件属性 = 
        查看文件内容
        cat
        vi
        查看文件属性 ls -l

    b 存储设备 块设备block
    c 字符设备 字符文件  鼠标
    d 目录 directory 蓝色
    - 普通文件
    ls -ld root 单独查看目录的属性
    3.2 stat命令
        inode 存放在文件属性里面
        同一个分区Inode唯一
        Links硬链接

        Access 修改之后第一次访问的时间
        Modify 文件内容修改的时间
        change 文件属性更改的时间
        
    4. cd命令
    5. pwd   print working directory
    6. touch
    6. mkdir  mkdir -p /test/te  连同父目录一起创建
    8. rm 
    9. mv
    10. cp /ch3  /ch4  -r  递归拷贝 连同子目录一起拷贝
    11. cat 
            Ctrl +D  发送一个EOF 结束标志
        cat file1 file2 连锁显示文件
        cat file1  file2 > file3 合并成一个文件 

    12. more
    13. less
    14. locate

4.链接
    软连接:类似于快捷方式  
            新建一个文件,保存了从当前为指导原文件的位置信息 指向
            ln -s test.c  test_soft.c   类似于符号链接
            
            ln -s  test_soft.c /home/.../tets.c  保存了绝对位置的信息 移动软连接 仍然有效



    硬链接: ln默认建立硬链接
------------------------------------------------------------------------------
第一章 Linux入门
    1.概述
        Linux内核的发明者:Linus
        类UNIX操作系统
        基于POSIX和UNIX的多用户 多任务 支持多线程的多CPU的操作系统
        性能稳定的操作系统
        知名的发行版本:Ubuntu RedHat Centos Debian Fedora suSE OpenSUSE
    1.1 Linux和Windows的区别

第二章 VM与Linux的安装
    1.网络设置
        1.1 桥接模式
        1.2 NAT模式
第三章 Linux文件与目录结构
    3.1 Linux文件
        一切皆文件
    3.2 目录结构
    -- 顶级目录是根目录 / 以树形结构展示
     -- 重点关注的目录
        -- /bin
        --/sbin
        --/home
        --/root
        --/lib
        --/etc 核心
        --/usr
        --/boot
        --/proc
        --/srv
        --/sys
        --/tmp
        --/dev
        --/media(Centos  6)
        --/ment
        --/opt
        --/var
第四章 VI/VIM编辑器(重要)
    1.一般模式
    2.编辑模式
    3.命令模式
第五章 网络配置和系统管理操作(重要)
    1.查看网络IP和网关
    2.配置网络ip
    3.配置主机名
    4.关闭防火墙
    5.关机重启命令
    6.找回root密码
第六章 远程登录
第七章 常用命令(重要)
第八章 软件包管理
第九章 克隆虚拟机
第十章 常见错误与解决方案
第十一章 企业真实面试题目
    11.1 百度&考满分
    11.2 瓜子二手车
