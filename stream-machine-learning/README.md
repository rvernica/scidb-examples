# Streaming and Machine Learning Example

* Requirements: `SciDB 16.9`
* See:
  [Machine Learning in SciDB](http://rvernica.github.io/2017/10/streaming-machine-learning)

The [`Dockerfile`](Dockerfile) provided here can be used to build a
Docker image which contains all the code necessary to follow the
examples in the
[Machine Learning in SciDB](http://rvernica.github.io/2017/10/streaming-machine-learning)
post. The Docker image can be build locally using:

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
$ docker run --tty rvernica/scidb-examples:stream-machine-learning
```

At start-up, the container starts a SciDB cluster with two
instances. The container contains all the code necessary to follow the
examples in the
[Machine Learning in SciDB](http://rvernica.github.io/2017/10/streaming-machine-learning)
post. The container *does not* contain any of the data necessary. The
data has to be downloaded separately from the Kaggle competition
[page](https://www.kaggle.com/c/digit-recognizer/data) and copy into
the container. For more details on how to use a Docker container
please refer to the Docker
[Get Started](https://docs.docker.com/get-started/part2/) tutorial.
