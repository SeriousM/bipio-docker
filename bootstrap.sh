#!/bin/bash
set -x
/usr/bin/mongod >> /data/server_logs/mongo.log 2>&1 &
/usr/sbin/rabbitmq-server >> /data/server_logs/rabbit.log 2>&1 &

perl -pi -e "s/127\.0\.0\.1/0.0.0.0/g" /usr/local/lib/node_modules/bipio/config/config.json-dist

cd /usr/local/lib/node_modules/bipio

npm install

supervisor ./src/server.js >> /data/server_logs/server.log 2>&1 &

/bin/bash -l
