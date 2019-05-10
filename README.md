# 综合布线的作业

作业环境复现方法,目的是搭建个web，ftp，dns服务器

**安装docker**

网上参考文章很多，建议用apt或者yum来安装



**配置docker的网络**

```
docker network create --subnet=172.18.0.0/16 mynetwork
```



**镜像搭建**

```
docker pull nickistre/centos-lamp
docker build -t sijidou:networkbuild .
```



**启动镜像**

```
./start.sh
```



**进入镜像需要干的事**

```
docker exec -it build2 bash

#设置ftptest的密码
passwd ftptest

#检查下服务是否启动
netstat -anot

#如果没有启动手动启动下,apache我记得基础镜像默认启动的
service named start
service vsftpd start

#如果通过容器自己解析自己的DNS，需要修改文件
vim /etc/resolv.conf

#添加内容
nameserver 172.18.0.101

#测试DNS方法
dig www.test.edu.cn
```



