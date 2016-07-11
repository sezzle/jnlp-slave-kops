FROM java:8-jdk
MAINTAINER Sezzle <jenkins@sezzle.com>

ENV HOME /home/jenkins

RUN useradd -c "Jenkins user" -d $HOME -m jenkins

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.52/remoting-2.52.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

COPY jenkins-slave /usr/local/bin/jenkins-slave

VOLUME /home/jenkins
WORKDIR /home/jenkins

USER jenkins

ENTRYPOINT ["jenkins-slave"]
​
USER root
​
RUN apt-get update && apt-get install -y libapparmor-dev
