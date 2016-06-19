FROM qnib/cos7

RUN yum install -y git-core make automake libtool gcc e2fsprogs debootstrap sudo \
 && git clone -b master --single-branch https://github.com/gmkurtzer/singularity.git \
 && cd singularity \
 && sh ./autogen.sh \
 && ./configure --prefix=/usr/local \
 && make \
 && make install \
 && adduser singularity \
 && echo "singularity   ALL=(ALL)   NOPASSWD: ALL" >> /etc/sudoers
RUN echo 'sudo /usr/local/bin/singularity create /tmp/centos7.img' >> /home/singularity/.bash_history  \
 && echo 'sudo /usr/local/bin/singularity bootstrap /tmp/centos7.img /data/centos.def' >> /home/singularity/.bash_history  \
USER singularity
