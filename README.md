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

## Docker compose version of it

After the `fedora.img` image is build **and** copied into the `/data/` directory, singularity can even be kicked off using `sshd`.
Not sure though if both nodes are used... Hmm...


```
➜  docker-singularity git:(master) ✗ docker-compose up -d
Creating singularity2
Creating singularity1
➜  docker-singularity git:(master) ✗ export IP1=$(docker inspect -f '{{ .NetworkSettings.Networks.bridge.IPAddress }}' singularity1)
➜  docker-singularity git:(master) ✗ export IP2=$(docker inspect -f '{{ .NetworkSettings.Networks.bridge.IPAddress }}' singularity2) 
➜  docker-singularity git:(master) ✗ docker exec -ti -u singularity singularity1  mpirun -np 4 --host ${IP1},${IP2} singularity exec /data/fedora.img /usr/bin/ring
Warning: Permanently added '172.17.0.3' (ECDSA) to the list of known hosts.
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
Process 2 exiting
Process 3 exiting
➜  docker-singularity git:(master) ✗
```
