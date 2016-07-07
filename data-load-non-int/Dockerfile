FROM rvernica/scidb:15.12-ext

## Install envsubst
RUN apt-get update; apt-get install --assume-yes gettext

COPY . /test
WORKDIR /test

## Re-create ".pgpass" file due to hard links created by Docker Hub
RUN cp /root/.pgpass /root/.pgpass.bk && mv /root/.pgpass.bk /root/.pgpass && \
    service ssh start && \
    service postgresql start && \
    scidb.py startall $SCIDB_NAME && \
    bash -e rec.sh && \
    iquery --afl --query-file test.afl > test.current && \
    diff test.gold test.current
