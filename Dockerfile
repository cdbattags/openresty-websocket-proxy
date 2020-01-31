FROM ubuntu:18.04

MAINTAINER Christian Battaglia "christian.d.battaglia@gmail.com"

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y wget gnupg2

# import OpenResty GPG key

RUN wget -qO - https://openresty.org/package/pubkey.gpg | apt-key add -
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"

RUN apt-get install -y nodejs openresty tmux

RUN service openresty stop

RUN apt-get install -y npm
RUN /usr/bin/npm install -g nodemon

# expose all ports

EXPOSE 443
EXPOSE 80
EXPOSE 9300
EXPOSE 22

# logs

RUN mkdir /var/log/nginx
RUN mkdir /var/log/amplify

# SSL config

RUN [ "/bin/bash", "-c", "openssl req -x509 -out /etc/ssl/certs/nginx-selfsigned.crt -keyout /etc/ssl/private/nginx-selfsigned.key -newkey rsa:2048 -nodes -sha256 -subj '/CN=localhost' -extensions EXT -config <( printf '[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth')" ]

# RUN printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth" | \
#     openssl req -x509 -out /etc/ssl/certs/nginx-selfsigned.crt -keyout /etc/ssl/private/nginx-selfsigned.key \
#     -newkey rsa:2048 -nodes -sha256 \
#     -subj '/CN=localhost'

# RUN (for i in {1..10}; do yes ""; done) | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt && echo

# entrypoint to setup the config

ENTRYPOINT ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]