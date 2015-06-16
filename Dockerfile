# c12e/mongodb

# use the c12e base OS
FROM c12e/debian
MAINTAINER Cognitive Scale congnitivescale.com

ENV MONGO_VER 3.0.3

RUN apt-get install -y lsb-release && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo "deb http://repo.mongodb.org/apt/debian "$(lsb_release -sc)"/mongodb-org/3.0 main" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list && \
  apt-get update && \
  sudo apt-get install -y mongodb-org=$MONGO_VER mongodb-org-server=$MONGO_VER mongodb-org-shell=$MONGO_VER mongodb-org-mongos=$MONGO_VER mongodb-org-tools=$MONGO_VER
  mkdir -p /data /logs  && \
  apt-get -y autoremove && \
  apt-get autoclean && \
  rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD run.sh /run.sh
ADD supervisord.conf /etc/supervisor/supervisord.conf

EXPOSE 27017 28017

CMD ["/usr/bin/supervisord"]

