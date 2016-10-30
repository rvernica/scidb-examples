FROM rvernica/scidb:15.12

RUN apt-get update && apt-get install --assume-yes --no-install-recommends \
        bc doxygen git


## Generate documentation
RUN cd $SCIDB_SOURCE_PATH && \
    echo 'add_subdirectory("doc")' >> CMakeLists.txt && \
    ./run.py setup --force && \
    cd stage/build && \
    make doc && \
    ls $SCIDB_SOURCE_PATH/stage/build/doc/api/html/index.html


## Make and install "dev_tools" plugin
RUN cd /usr/local/src && \
    git clone https://github.com/Paradigm4/dev_tools.git && \
    make --directory=/usr/local/src/dev_tools && \
    cp /usr/local/src/dev_tools/*.so \
        $SCIDB_INSTALL_PATH/lib/scidb/plugins


COPY . /test
WORKDIR /test

## Re-create ".pgpass" file due to hard links created by Docker Hub
RUN cp /root/.pgpass /root/.pgpass.bk && mv /root/.pgpass.bk /root/.pgpass && \
    service ssh start && \
    service postgresql start && \
    scidb.py startall $SCIDB_NAME && \
    iquery --afl --query-file query.afl | tee test.current && \
    diff test.gold test.current
