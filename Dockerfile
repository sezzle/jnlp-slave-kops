FROM java:8-jdk-alpine
MAINTAINER Sezzle <jenkins@sezzle.com>

ENV HOME /home/jenkins

RUN adduser -S -h $HOME jenkins jenkins

RUN apk add --update --no-cache curl \
  && curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.52/remoting-2.52.jar
  && chmod 644 /usr/share/jenkins/slave.jar \
  && apk del curl

COPY jenkins-slave /usr/local/bin/jenkins-slave

VOLUME /home/jenkins
WORKDIR /home/jenkins

USER jenkins

ENTRYPOINT ["jenkins-slave"]
​
USER root
​
RUN apt-get update && apt-get install -y libapparmor-dev
