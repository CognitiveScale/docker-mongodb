#!/bin/bash
#
data=${MONGODB_DATA:-/data}
rs=${MONGODB_RS:-rs0}

if [ "$(ls -A $data)" ];then
    echo "mongodb data directory is found at " $MONGODB_DATA
else
    echo "downloading mongodb data... "
    cd $(dirname $data)
    wget -qO- https://s3.amazonaws.com/c1sandbox/downloads/mongodb/data.v2.tgz | tar zxvf -
fi

echo "starting mongodb..."
exec mongod --dbpath $data --replSet $rs --rest
