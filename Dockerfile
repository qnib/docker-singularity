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
 && echo 'sudo /usr/local/bin/singularity bootstrap /tmp/centos7.img /data/centos.def' >> /home/singularity/.bash_history \
 && echo 'sudo /usr/local/bin/singularity create /tmp/fedora.img' >> /home/singularity/.bash_history \
 && echo 'sudo /usr/local/bin/singularity expand /tmp/fedora.img' >> /home/singularity/.bash_history \
 && echo 'sudo /usr/local/bin/singularity exec -w /tmp/fedora.img dnf groupinstall -y "Development Tools"' >> /home/singularity/.bash_history 

## Openmpi
RUN yum groupinstall -y "Development Tools" \
 && git clone https://github.com/open-mpi/ompi.git /tmp/ompi \
 && cd /tmp/ompi \
 && ./autogen.pl \
 && ./configure --prefix=/usr/local \
 && make \
 && make install
ADD ompi.sh /opt/

echo "mpirun -np 4 singularity exec /tmp/fedora.img /usr/bin/ring" >> /home/singularity/.bash_history
USER singularity
