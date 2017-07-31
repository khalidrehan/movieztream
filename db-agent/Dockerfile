# install Java7 from http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.rpm

FROM centos:centos7

MAINTAINER Carlos Doki (carlosdoki@gmail.com)

#hack for centos docker bug
RUN mkdir -p /run/lock

#JDK
RUN mkdir -p /arquivos
ADD unzip-6.0-13.el7.x86_64.rpm /arquivos
RUN rpm -Uvh /arquivos/unzip-6.0-13.el7.x86_64.rpm

ADD jdk-7u80-linux-x64.rpm /arquivos
RUN rpm -Uvh /arquivos/jdk-7u80-linux-x64.rpm

RUN rm /arquivos/jdk-7u80-linux-x64.rpm
ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin

#Agent Install
ENV AGENT_HOME /dbagent
ADD dbagent.zip /
RUN unzip /dbagent.zip -d ${AGENT_HOME}
RUN rm dbagent.zip

RUN rm -Rf /arquivos

ADD startup.sh /
RUN chmod +x /startup.sh
WORKDIR /
CMD ["/bin/bash","/startup.sh"]
