# c12e/mongodb

# use the c12e base OS
FROM c12e/debian
MAINTAINER Cognitive Scale congnitivescale.com

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' > /etc/apt/sources.list.d/mongodb.list && \
  apt-get update && \
  apt-get -y install mongodb-10gen && \
  mkdir -p /data /logs  && \
  apt-get -y autoremove && \
  apt-get autoclean && \
  rm -rf /var/cache/apt/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD run.sh /run.sh
ADD supervisord.conf /etc/supervisor/supervisord.conf

EXPOSE 27017 28017
VOLUME ["/data", "/logs"]

CMD ["/usr/bin/supervisord"]

