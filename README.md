# GraphDB-SE Image

This repository contains a Dockerfile for building an image with the latest version of **GraphDB-SE 8** supported by [Knora](https://github.com/dhlab-basel/Knora).

GraphDB-SE is the Standard Edition of the triplestore from Ontotext (http://ontotext.com). GraphDB-SE must be licensed separately by the user.

## Usage


### Docker Hub

Copy the GraphDB-SE license file into a folder of you choosing and name it ``GRAPHDB_SE.license``. We will mount this
folder into the docker container, so that the license can be used by GraphDB running inside the container.

```
$ docker run --rm -it -v /path/to/license/folder:/external -p 3030:3030 dhlabbasel:fuseki
```


### Local Build

Checkout this repository and then run:

```
$ docker build -t graphdb .
$ docker run --rm -it -v /path/to/license/folder:/external -p 7200:7200 graphdb
```

Do not forget the '.' in the first command.

 - ``--rm`` removes the container as soon as you stop it
 - ``-p`` forwards the exposed port to your host (or if you use boot2docker to this IP)
 - ``-it`` allows interactive mode, so you see if something get's deployed

After the GraphDB inside the docker container has started, you can find the GraphDB workbench here: http://localhost:7200

Above, we create and start a transient container (``--rm`` flag). To create a container that we can stop and start again
at a later time, follow the following steps:

```
  $ docker build -t graphdb <path-to-dockerfile>
  $ docker run --name graphdb -d -t -v /path/to/license/folder:/external -p 7200:7200 graphdb
  
  (to see the console output, attach to the container; to detach press Ctrl-c)
  $ docker attach graphdb
    
  (to stop the container)
  $ docker stop graphdb
  
  (to start the container again)
  $ docker start graphdb
  
  (to remove the container; needs to be stopped)
  $ docker rm graphdb
```

 - ``--name`` give the container a name
 - ``-d`` run container in background and print container ID
 - ``-t`` allocate a pseudo TTY, so you see the console output
 - ``-p`` forwards the exposed port to your host