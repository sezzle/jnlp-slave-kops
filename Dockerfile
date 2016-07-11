FROM java:8-jdk-alpine

MAINTAINER Sezzle <jenkins@sezzle.com>

#Set Environment Varaibles for Jenkins and GO
ENV HOME /home/jenkins
ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN adduser -S -h $HOME jenkins jenkins

RUN apk add --update --no-cache curl ca-certificates go make

  RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.60/remoting-2.60.jar \
  && chmod 644 /usr/share/jenkins/slave.jar \
  && go get -d k8s.io/kops \
  && cd ${GOPATH}/src/k8s.io/kops \
  && make \
  && apk del curl

COPY jenkins-slave /usr/local/bin/jenkins-slave

VOLUME /home/jenkins

WORKDIR /home/jenkins

USER jenkins

ENTRYPOINT ["jenkins-slave"]

#TODO: Add all dependencies that can be deleted to a virtual in apk.
