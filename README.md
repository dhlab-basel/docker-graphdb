# GraphDB-SE Image

This repository contains a Dockerfile for building **GraphDB-SE**.

GraphDB-SE is the Standard Edition of the triplestore from Ontotext (http://ontotext.com). GraphDB-SE must be licensed separately by the user.

## Usage


### Docker Hub

Copy the GraphDB-SE license file into a folder of you choosing and name it ``GRAPHDB_SE.license``. We will mount this
folder into the docker container, so that the license can be used by GraphDB running inside the container.

```
$ docker run -d -p 127.0.0.1:7200:7200 -v /path/to/data/folder:/opt/graphdb/home dhlabbasel/graphdb:8.5.0-RC.8-se
```
