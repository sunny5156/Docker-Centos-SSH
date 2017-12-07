# Docker-Centos-SSH
Docker-Centos-SSH
centos nginx php 

## 运行命令


docker run --privileged --restart=always -it -d --name="docker-centos" -p 80:80 -p 443:443 -p 2022:22 -v /sunny/Data/docker-centos:/data registry.alauda.cn/sunny5156/docker-centos-ssh  /usr/sbin/init
