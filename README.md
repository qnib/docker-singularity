# docker-singularity

CentOS container holding Singularity

## Fedora 23

```
$ docker run -ti --privileged -v /Users/kniepbert/docker/docker-singularity/data/:/data/ -w /home/singularity/ -u singularity qnib/singularity bash
[singularity@6999f432b4c9 ~]$ /opt/ompi.sh
*snip*
make[1]: Leaving directory '/home/singularity/ompi'
[singularity@6999f432b4c9 ompi]$ sudo /usr/local/bin/singularity exec -w /tmp/fedora.img /usr/local/bin/mpicc examples/ring_c.c -o ring
Singularity: User=root[0], Command=exec, Container=/tmp/fedora.img, CWD=/home/singularity/ompi, Arg1=/usr/local/bin/mpicc
[singularity@6999f432b4c9 ompi]$ sudo /usr/local/bin/singularity copy /tmp/fedora.img ./ring /usr/bin/
[singularity@6999f432b4c9 ompi]$ mpirun -np 4 singularity exec /tmp/fedora.img /usr/bin/ring
Singularity: User=singularity[1000], Command=exec, Container=/tmp/fedora.img, CWD=/home/singularity/ompi, Arg1=/usr/bin/ring
Singularity: User=singularity[1000], Command=exec, Container=/tmp/fedora.img, CWD=/home/singularity/ompi, Arg1=/usr/bin/ring
Singularity: User=singularity[1000], Command=exec, Container=/tmp/fedora.img, CWD=/home/singularity/ompi, Arg1=/usr/bin/ring
Singularity: User=singularity[1000], Command=exec, Container=/tmp/fedora.img, CWD=/home/singularity/ompi, Arg1=/usr/bin/ring
Process 0 sending 10 to 1, tag 201 (4 processes in ring)
Process 0 sent to 1
Process 0 decremented value: 9
Process 0 decremented value: 8
Process 0 decremented value: 7
Process 0 decremented value: 6
Process 0 decremented value: 5
Process 0 decremented value: 4
Process 0 decremented value: 3
Process 0 decremented value: 2
Process 0 decremented value: 1
Process 0 decremented value: 0
Process 0 exiting
Process 1 exiting
Process 3 exiting
Process 2 exiting
[singularity@6999f432b4c9 ompi]$
```
