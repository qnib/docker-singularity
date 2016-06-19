# docker-singularity

CentOS container holding Singularity

## Fedora 23

```
$ docker run -ti --privileged -v /Users/kniepbert/docker/docker-singularity/data/:/data/ -w /root/ -u root qnib/singularity bash
sudo /usr/local/bin/singularity create /tmp/centos7.img
sudo /usr/local/bin/singularity bootstrap /tmp/centos7.img /data/centos.def USER singularity
sudo /usr/local/bin/singularity create /tmp/centos7.img
sudo /usr/local/bin/singularity bootstrap /tmp/centos7.img /data/centos.def
sudo /usr/local/bin/singularity create /tmp/fedora.img
sudo /usr/local/bin/singularity expand /tmp/fedora.img
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img bash
sudo /usr/local/bin/singularity bootstrap /tmp/fedora.img /data/fedora23.def
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img dnf groupinstall -y "Development Tools"
git clone https://github.com/open-mpi/ompi.git
cd ompi
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img ./autogen.pl
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img ./configure --prefix=/usr/local
```
