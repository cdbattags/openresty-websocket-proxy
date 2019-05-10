# websocket NGINX testing

1. `docker build -t cdbattags/nginx-express-websocket .`
2. `docker run -d -p 8080:80 -p 8443:443 -p 9300:9300 -p 8022:22 -v $PWD:/mounted cdbattags/nginx-express-websocket -c /mounted/nginx/nginx.conf`