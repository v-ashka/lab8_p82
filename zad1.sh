#!/bin/bash
docker network create -d bridge --subnet 10.0.10.0/24 bridge1
docker run -itd --name T1 alpine
docker run -itd --name D1 --net bridge1 --ip 10.0.10.254 alpine
docker run -itd --name T2 --net bridge1 -p 80:80 -p 10.0.10.1:8000:80 nginx

docker network inspect bridge
docker network inspect bridge1
ip route list