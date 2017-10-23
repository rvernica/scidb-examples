# Streaming and Machine Learning Example

* Requirements: `SciDB 16.9`
* See:
  [Machine Learning in SciDB](http://rvernica.github.io/2017/10/streaming-machine-learning)

The [`Dockerfile`](Dockerfile) provided here can be used to build a
Docker image which contains all the code necessary to follow the
examples in the
[Machine Learning in SciDB](http://rvernica.github.io/2017/10/streaming-machine-learning)
post. The Docker image can be built locally using:

```bash
$ docker build --tag rvernica/scidb-examples:stream-machine-learning .
```

Alternatively, an already built Docker image can be downloaded from
[Docker Hub](https://hub.docker.com/r/rvernica/scidb-examples) using:

```bash
$ docker pull rvernica/scidb-examples:stream-machine-learning
```

Once the Docker image is available a Docker container can be
started using:

```bash
$ docker run --tty --name scidb-example \
      rvernica/scidb-examples:stream-machine-learning
```

At start-up, the container starts a SciDB cluster with two
instances. The container contains all the code necessary to follow the
examples in the
[Machine Learning in SciDB](http://rvernica.github.io/2017/10/streaming-machine-learning)
post. The container does *not* contain any of the necessary data. The
data has to be downloaded separately from the Kaggle competition
[page](https://www.kaggle.com/c/digit-recognizer/data) and copied into
the container:

```bash
$ docker exec scidb-example mkdir /kaggle
$ docker cp train.csv scidb-example:/kaggle/train.csv
$ docker cp test.csv scidb-example:/kaggle/test.csv
```

The code from the
[Machine Learning in SciDB](http://rvernica.github.io/2017/10/streaming-machine-learning)
post is available in `/usr/local/src/stream-python/py_pkg/examples/4-machine-learning.py` and can be run using:

```bash
$ docker exec scidb-example python \
      /usr/local/src/stream-python/py_pkg/examples/4-machine-learning.py
UserWarning: 2 type(s) promoted for null support. Precision loss may occur
```

The output file with predictions is available in the container in
`/results.csv` while all the intermediate arrays are available in
SciDB. For more details on how to use a Docker container please refer
to the Docker
[Get Started](https://docs.docker.com/get-started/part2/) tutorial.
