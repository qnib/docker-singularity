FROM qnib/cos7

RUN yum install -y git-core make automake libtool gcc e2fsprogs debootstrap \
 && git clone -b master --single-branch https://github.com/gmkurtzer/singularity.git \
 && cd singularity \
 && sh ./autogen.sh \
 && ./configure --prefix=/usr/local \
 && make \
 && make install
RUN adduser singularity
