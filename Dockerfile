FROM jenkinsci/jnlp-slave
​
MAINTAINER Sezzle <jenkins@sezzle.com>
​
USER root
​
RUN apt-get update && apt-get install -y libapparmor-dev
