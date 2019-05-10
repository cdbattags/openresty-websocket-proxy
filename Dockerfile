FROM ubuntu:18.04

MAINTAINER Christian Battaglia "christian.d.battaglia@gmail.com"

# import OpenResty GPG key

RUN wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"

# update packages

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y nodejs openresty

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN apt-get install -y npm
RUN /usr/bin/npm install -g nodemon

RUN cd /mounted && npm install

#expose all ports

EXPOSE 443
EXPOSE 80
EXPOSE 9300
EXPOSE 22

# start the node app

RUN nodemon /mounted/backend/app.js

# entrypoint to setup the config

RUN mkdir /var/log/nginx
ENTRYPOINT ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]