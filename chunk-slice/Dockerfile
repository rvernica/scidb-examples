FROM rvernica/scidb:15.12

COPY . /test
WORKDIR /test

## Re-create ".pgpass" file due to hard links created by Docker Hub
RUN cp /root/.pgpass /root/.pgpass.bk && mv /root/.pgpass.bk /root/.pgpass && \
    service ssh start && \
    service postgresql start && \
    scidb.py startall $SCIDB_NAME && \
    iquery --afl --query-file query.afl | tee test.current && \
    diff test.gold test.current
