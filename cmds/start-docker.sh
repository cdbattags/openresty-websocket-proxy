#!/bin/bash

docker run -d --name=nginx-express-websocket -p 9080:80 -p 9443:443 -p 9300:9300 -p 9022:22 -v $PWD:/mounted cdbattags/nginx-express-websocket -c /mounted/nginx/nginx.conf &&
docker exec -it nginx-express-websocket nohup sh /mounted/cmds/inside-docker.sh &&
sh ./cmds/enter-docker.sh