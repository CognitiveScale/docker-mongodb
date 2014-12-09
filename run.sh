#!/bin/bash
#

if [ "$(ls -A $MONGODB_DATA)" ];then
    echo "mongodb data directory is found at " $MONGODB_DATA
else
    echo "downloading mongodb data... "
    cd $(dirname $MONGODB_DATA)
    wget -qO- https://s3.amazonaws.com/c1sandbox/downloads/mongodb/data.v2.tgz | tar zxvf -
fi

echo "starting mongodb..."
exec mongod --dbpath $MONGODB_DATA --replSet $MONGODB_RS --rest
