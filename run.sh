#!/bin/bash

data=${MONGODB_DATA:-/data}
rs=${MONGODB_RS:-rs0}

if [ "$(ls -A $data)" ];then
    echo "mongodb data directory is found at " $data
else
  echo "Creating intial Replication Set "

  nohup mongod --dbpath $data --replSet $rs --rest > /logs/create_replset.log 2> /dev/null &
  mongod_pid=$!

  while [ `tail  /logs/create_replset.log 2> /dev/null | grep -c 'port 27017'` -eq 0 ];
  do
    sleep 1
  done

  # connect to one server and initiate the set
  mongo localhost/admin  << 'EOF'
  config = { _id: "rs0", members:[
           { _id : 0, host : "localhost:27017" }]};
  rs.initiate(config)
EOF

  while [ `tail  /logs/create_replset.log 2> /dev/null | grep -c 'replSet PRIMARY'` -eq 0 ];
  do
    sleep 1
  done

  kill $mongod_pid
fi

echo "starting mongodb..."
exec mongod --dbpath $data --replSet $rs --rest
