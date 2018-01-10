# Docker-Centos-SSH
Docker-Centos-SSH

centos nginx php ssh

## 运行命令

```
docker run --privileged --restart=always -it -d --name="docker-centos" -p 80:80 -p 443:443 -p 2022:22 -v /sunny/Data/docker-centos:/data daocloud.io/sunny5156/docker-centos-ssh  /usr/sbin/init

```



> /sunny/Data/docker-centos 此path自己替换成自己的。
> 
> 镜像在DaoCloud上，[daocloud.io/sunny5156/docker-centos-ssh](http://hub.daocloud.io/repos/e5d424a4-a62c-4bdd-bdd7-c13399447e6b) 可以根据自己喜好自己创建

## 版本升级

> 灵雀云存在问题,切换至Daocloud

## 登陆docker-centos

```
ssh -p 2022 root@localhost
pwd：123456
```
