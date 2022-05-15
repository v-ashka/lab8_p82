#!/bin/bash
docker run -itd --name T2 -p 80:80 alpine
docker run -itd --name T1 --link T2:mylink alpine

docker exec T1 ping -c 4 mylink
docker exec T1 cat /etc/hosts
docker exec T1 printenv | grep MYLINK