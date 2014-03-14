# DOCKER-VERSION 0.6.1

FROM	ubuntu:12.04
MAINTAINER Vlad Verestiuc "verestiuc.vlad@gmail.com"


ENV 	DEBIAN_FRONTEND noninteractive

RUN 	locale-gen en_US.UTF-8
ENV 	LC_ALL en_US.UTF-8

RUN	echo 'deb http://us.archive.ubuntu.com/ubuntu/ precise universe' >> /etc/apt/sources.list
RUN	apt-get -y update
# Install required packages
RUN	apt-get -y install wget pgtune apg
RUN 	wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -


RUN 	echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' >> /etc/apt/sources.list
RUN	apt-get -y update
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d
RUN	apt-get -y install postgresql-9.3 postgresql-9.3-postgis
RUN 	pg_dropcluster 9.3 main 
RUN 	apt-get clean
RUN 	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD	./postgresql /bin/postgresql
	

CMD	["postgresql"]


