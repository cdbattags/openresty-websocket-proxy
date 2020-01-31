#!/bin/bash

cd /mounted && npm install

nodemon /mounted/backend/app.js 2> /var/log/amplify/error.log > /var/log/amplify/out.log &



