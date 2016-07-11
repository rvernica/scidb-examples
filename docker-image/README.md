# Docker Image Example

The provided [Dockerfile](Dockerfile) builds a [Docker](https://www.docker.com/) image for SciDB `15.12`. The Dockerfile follows, step by step, the instructions provided in the official documentation, [SciDB Community Edition Installation Guide](https://paradigm4.atlassian.net/wiki/display/ESD/SciDB+Community+Edition+Installation+Guide). See [Unleashing SciDB in a Docker Container](http://rvernica.github.io/2016/06/docker-image) for more details.

The image is space *inefficient* (its size is `6GB`) and does *not* follow the Dockerfile best practices. This image is just an example. More efficient SciDB Docker images are available in the [docker-library](https://github.com/rvernica/docker-library/tree/master/scidb) repository.

## Building the Image

The image can be built locally using:

```python
# docker build --tag scidb .
```

The image installs SciDB dependencies, downloads the SciDB source code, and builds and installs SciDB. The official location for SciDB source code is on [Google Drive](https://drive.google.com/folderview?id=0B7yt0n33Us0rT1FJdmxFV2g0OHc&usp=drive_web#list), but because Google Drive does not provide direct access to files (for example using `wget`), a non-official mirror of the SciDB source in [Bintray](https://bintray.com/rvernica/generic/scidb-src/15.12#files) is used.

## Using the Image

The image contains an [`ENTRYPOINT`](https://docs.docker.com/engine/reference/builder/#/entrypoint) script which starts the SSH, PostgeSQL and SciDB servers. Upon exit, the script stops the SciDB and PostgreSQL servers. A container can be started from this image using:

```bash
$ docker run --tty --interactive --name scidb scidb
 * Starting OpenBSD Secure Shell server sshd                             [ OK ]
 * Starting PostgreSQL 9.3 database server                               [ OK ]
scidb.py: INFO: Found 0 scidb processes
scidb.py: INFO: start((server 0 (127.0.0.1) local instance 0))
scidb.py: INFO: Starting SciDB server.
scidb.py: INFO: start((server 0 (127.0.0.1) local instance 1))
scidb.py: INFO: Starting SciDB server.
scidb.py: INFO: start((server 0 (127.0.0.1) local instance 2))
scidb.py: INFO: Starting SciDB server.
scidb.py: INFO: start((server 0 (127.0.0.1) local instance 3))
scidb.py: INFO: Starting SciDB server.
root@132b6b44786f:/usr/src/scidbtrunk# iquery --afl --query "list('libraries')"
{inst,n} name,major,minor,patch,build,build_type
{0,0} 'SciDB',15,12,1,80403125,'Debug'
{1,0} 'SciDB',15,12,1,80403125,'Debug'
{2,0} 'SciDB',15,12,1,80403125,'Debug'
{3,0} 'SciDB',15,12,1,80403125,'Debug'
root@132b6b44786f:/usr/src/scidbtrunk# exit
exit
scidb.py: INFO: stop(server 0 (127.0.0.1))
scidb.py: INFO: Found 0 scidb processes
 * Stopping PostgreSQL 9.3 database server                               [ OK ]
$ docker rm scidb
```
