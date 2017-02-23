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
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]