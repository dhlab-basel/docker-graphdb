FROM ubuntu:16.04

MAINTAINER Ivan Subotic "ivan.subotic@unibas.ch"

# Silence debconf messages
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -qq update && \
  apt-get -y install \
    byobu curl git htop man vim wget unzip \
    openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

RUN \
  curl -sS -o /tmp/graphdb.zip -L http://maven.ontotext.com/content/groups/all-onto/com/ontotext/graphdb/graphdb-se/8.5.0-RC8/graphdb-se-8.5.0-RC8-dist.zip && \
  unzip /tmp/graphdb.zip -d /tmp && \
  mv /tmp/graphdb-se-8.5.0-RC8 /graphdb && \
  git clone -b develop --single-branch --depth=1 https://github.com/dhlab-basel/Knora.git /knora && \
  cp /knora/webapi/scripts/KnoraRules.pie /graphdb && \
  rm /tmp/graphdb.zip && \
  rm -rf /knora

WORKDIR /graphdb

EXPOSE 7200

# Set GraphDB Max and Min Heap size
ENV GDB_HEAP_SIZE="2g"

CMD ["./bin/graphdb", "-Dgraphdb.license.file=/external/GRAPHDB_SE.license"]
