#!/bin/bash

set -ex

sudo /usr/local/bin/singularity create /tmp/fedora.img
sudo /usr/local/bin/singularity expand /tmp/fedora.img
sudo /usr/local/bin/singularity expand /tmp/fedora.img
sudo /usr/local/bin/singularity bootstrap /tmp/fedora.img /data/fedora23.def
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img dnf groupinstall -y "Development Tools"
git clone https://github.com/open-mpi/ompi.git
cd ompi
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img ./autogen.pl
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img ./configure --prefix=/usr/local
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img make
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img make install
sudo /usr/local/bin/singularity exec -w /tmp/fedora.img /usr/local/bin/mpicc examples/ring_c.c -o ring
sudo /usr/local/bin/singularity copy /tmp/fedora.img ./ring /usr/bin/
