#!/bin/bash

docker build -t cdbattags/nginx-express-websocket . &&
sh ./cmds/start-docker.sh