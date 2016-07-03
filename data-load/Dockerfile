FROM scidb:15.12-ubuntu-aio
ENV SCIDB_NAME=mydb

COPY . /test

RUN service ssh start && \
    service postgresql start && \
    scidb.py startall $SCIDB_NAME && \
    bash -e /test/rec.sh
