## SciDB Community Edition Installation Guide
## ===
## https://paradigm4.atlassian.net/wiki/display/ESD/SciDB+Community+Edition+Installation+Guide

## Requirements
## ---
FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y wget apt-transport-https software-properties-common

## Installation Notes
## ---
ARG host_ip=127.0.0.1
ARG net_mask=$host_ip/8
ARG scidb_usr=scidb
ARG dev_dir=/usr/src

RUN groupadd $scidb_usr
RUN useradd $scidb_usr -s /bin/bash -m -g $scidb_usr


## Pre-Installation Tasks
## ===
## https://paradigm4.atlassian.net/wiki/display/ESD/Pre-Installation+Tasks

## Download SciDB Community Edition
## ---
WORKDIR $dev_dir
RUN wget --no-verbose \
        https://dl.bintray.com/rvernica/generic/scidb-15.12.1.4cadab5.tar.gz
RUN tar -xzf scidb-15.12.1.4cadab5.tar.gz
RUN mv scidb-15.12.1.4cadab5 scidbtrunk
WORKDIR $dev_dir/scidbtrunk

## Installing Expect, and SSH Packages
## --
RUN apt-get install -y expect openssh-server openssh-client

## Providing Passwordless SSH
## ---
RUN ssh-keygen -f /root/.ssh/id_rsa -N ''
RUN chmod 755 /root
RUN chmod 755 /root/.ssh

RUN mkdir /home/$scidb_usr/.ssh
RUN ssh-keygen -f /home/$scidb_usr/.ssh/id_rsa -N ''
RUN chmod 755 /home/$scidb_usr
RUN chmod 755 /home/$scidb_usr/.ssh

## Avoid setting passwrod and providing it to "deploy.sh access"
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN cat /root/.ssh/id_rsa.pub >> /home/$scidb_usr/.ssh/authorized_keys

## Set correct ownership
RUN chown -R $scidb_usr:$scidb_usr /home/$scidb_usr

RUN service ssh start && \
    ./deployment/deploy.sh access root NA "" $host_ip && \
    ./deployment/deploy.sh access $scidb_usr NA "" $host_ip && \
    ssh $host_ip date

## Installing Build Tools
## ---
RUN service ssh start && \
    ./deployment/deploy.sh prepare_toolchain $host_ip

## Installing Postgres
## ---
RUN service ssh start && \
    ./deployment/deploy.sh prepare_postgresql postgres postgres $net_mask $host_ip

## Providing the postgres user Access to SciDB Code
RUN usermod -G $scidb_usr -a postgres
RUN chmod g+rx $dev_dir
RUN /usr/bin/sudo -u postgres ls $dev_dir


## Installing SciDB Community Edition
## ===
## https://paradigm4.atlassian.net/wiki/display/ESD/Installing+SciDB+Community+Edition

## Configuring Environment Variables
## ---
ENV SCIDB_VER=15.12
ENV SCIDB_INSTALL_PATH=$dev_dir/scidbtrunk/stage/install
ENV SCIDB_BUILD_TYPE=Debug
ENV PATH=$SCIDB_INSTALL_PATH/bin:$PATH

RUN echo "\
export SCIDB_VER=$SCIDB_VER\n\
export SCIDB_INSTALL_PATH=$SCIDB_INSTALL_PATH\n\
export SCIDB_BUILD_TYPE=$SCIDB_BUILD_TYPE\n\
export PATH=$PATH\n" | tee /root/.bashrc > /home/$scidb_usr/.bashrc


### Activating and Verifying the New .bashrc File
RUN echo $SCIDB_VER
RUN echo $SCIDB_INSTALL_PATH
RUN echo $PATH

## Building SciDB CE
## ---
RUN ./run.py setup --force
RUN ./run.py make -j4

## Installing SciDB CE
## ---
RUN service ssh start && \
    service postgresql start && \
    echo "\n\ny" | ./run.py install --force


## Starting and Stopping SciDB
## ===
## https://paradigm4.atlassian.net/wiki/display/ESD/Starting+and+Stopping+SciDB

RUN echo "#!/bin/bash\n\
service ssh start\n\
service postgresql start\n\
scidb.py startall mydb\n\
trap \"scidb.py stopall mydb; service postgresql stop\" EXIT HUP INT QUIT TERM\n\
bash" > /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

## Starting SciDB
## ---
ENTRYPOINT ["/docker-entrypoint.sh"]
