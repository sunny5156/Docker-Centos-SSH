# 选择一个已有的os镜像作为基础
FROM centos:centos7

# 镜像的作者
MAINTAINER sunny5156 <sunny5156@qq.com>

# 安装openssh-server和sudo软件包，并且将sshd的UsePAM参数设置成no,安装net-tools工具
RUN yum install -y openssh-server sudo net-tools
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# 添加测试用户super，密码super，并且将此用户添加到sudoers里
RUN useradd super
RUN echo "super:super" | chpasswd
RUN echo "super   ALL=(ALL)       ALL" >> /etc/sudoers

# 下面这两句比较特殊，在centos6上必须要有，否则创建出来的容器sshd不能登录
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

# 启动sshd服务并且暴露22端口
RUN mkdir /var/run/sshd

# 安装 nginx php
RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install initscripts;

ADD remi-release-6.rpm /tmp/remi-release-6.rpm

RUN rpm -ivh /tmp/remi-release-6.rpm
#RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

# add nginx repo
ADD nginx.repo /etc/yum.repos.d/nginx.repo

# Install supervisor
RUN yum install -y python-setuptools; yum clean all
RUN easy_install pip
RUN pip install supervisor

# Install nginx
RUN yum -y install nginx; yum clean all;

# Install PHP
RUN yum -y --enablerepo=remi,remi-php56 --skip-broken install php-fpm php-common php-cli php-pdo php-mysql php-gd php-imap php-ldap php-odbc php-opcache php-pear php-xml php-devel php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash libmcrypt; yum clean all;

# Add the configuration file of the nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf

# Add the file
ADD index.php /var/www/html/index.php

#Add supervisord conf
ADD supervisord.conf /etc/supervisord.conf

RUN chkconfig nginx on
RUN chkconfig php-fpm on

ADD init.sh  /init.sh
RUN chmod +x /init.sh

#RUN /init.sh

#Open firewall ports
#RUN firewall-cmd --permanent --add-service=http
#RUN firewall-cmd --permanent --add-service=https
#RUN firewall-cmd --reload
# 安装 nginx php


EXPOSE 22 80 443
CMD ["/usr/sbin/sshd", "-D"]