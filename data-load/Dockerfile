FROM rvernica/scidb:15.12-ext

COPY . /test

RUN service ssh start && \
    service postgresql start && \
    scidb.py startall $SCIDB_NAME && \
    bash -e /test/rec.sh
