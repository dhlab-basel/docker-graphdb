FROM ubuntu:16.04

MAINTAINER Ivan Subotic "ivan.subotic@unibas.ch"

# Silence debconf messages
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get -qq update && \
  apt-get -y install \
        curl git wget unzip \
        software-properties-common

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer


# Set environment variables
ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"
ENV LANG="en_US.UTF-8"
ENV JAVA_OPTS="-Dsun.jnu.encoding=UTF-8 -Dfile.encoding=UTF-8"

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

CMD ["/graphdb/bin/graphdb", "-Dgraphdb.home=/opt/graphdb/home"]
