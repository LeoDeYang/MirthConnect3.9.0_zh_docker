# MirthConnect3.9.0_zh_docker  
mc3.9.0汉化版的docker镜像，下载即可用。  
mc官网：http://www.mirthcorp.com/community/issues/browse/MIRTH  
mc官网文档：http://www.mirthcorp.com/community/wiki/display/mirth/Getting+Started+Guide  
mc社区，可注册账号浏览：https://forums.mirthproject.io/  
mc最新版下载地址：http://downloads.mirthcorp.com/archive/connect/3.9.0.b2526/  
本仓库只是展示镜像制作与使用。需要使用镜像可到Dockerhub 和  阿里云镜像中  搜索mirthconnect3.9.0关键字拉取使用。


Dockerfile文件：解读  
#基础镜像为 jdk1.8 有几种版本，选择了一个最小的  
FROM openjdk:8-jdk-alpine  
# 作者邮箱  
MAINTAINER leodockeryang<1064894600@qq.com>  

#将tar.gz包拷贝到镜像内/usr/local下 此处可以用ADD  
COPY mirthconnect3.9.0_zh.tar.gz /usr/local    
# 当前目录下解压缩包并删除压缩包 此处可以直接用ADD  
RUN tar -zxvf /usr/local/mirthconnect3.9.0_zh.tar.gz -C /usr/local && rm -f /usr/local/mirthconnect3.9.0_zh.tar.gz    
# 环境变量工作目录  
ENV MYPATH /usr/local/mirthconnect3.9.0_zh    
WORKDIR $MYPATH    

EXPOSE 8080 8443    
# 容器启动时打印一下工作目录并运行mc服务端  
CMD echo $MYPATH && java -jar mirth-server-launcher.jar && /bin/bash  


# 启动方式一：不向宿主机共享任何目录    
# docker run -it -p 8080:8080 -p 8443:8443 --name 容器名 镜像名:版本号    
# docker run -it -p 8080:8080 -p 8443:8443 --name mc01 mirthconnect3.9.0_zh:1.0      
docker run -d -p 8080:8080 -p 8443:8443 --name mc01 mirthconnect3.9.0_zh:1.0   

# 启动方式二：共享mc中的appdata数据目录到宿主机某个目录（可定义）  
# 其实就是在启动方式一上加  -v  数据卷挂载命令    -v 宿主机目录（可自定义）:容器内目录    
docker run -d -v /usr/local/mirth/appdata:/usr/local/mirthconnect3.9.0_zh/appdata -p 8080:8080 -p 8443:8443 --name mc01 mirthconnect3.9.0_zh:1.0    

# 启动方式三：挂载mc中的logs日志目录到宿主机某个目录    
# 其实就是在启动方式一上加  -v  数据卷挂载命令    -v 宿主机目录:容器内目录    
docker run -d -v /usr/local/mirth/logs:/usr/local/mirthconnect3.9.0_zh/logs -p 8080:8080 -p 8443:8443 --name mc01 mirthconnect3.9.0_zh:1.0  

容器启动方式四  
共享mc中的conf目录到宿主机某个目录；方便在容器外部修改mc配置；修改后需要重启容器；  
经过测试，mc中conf配置目录，不能被共享出来；
