# install Java7 from http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.rpm

FROM centos:centos7

MAINTAINER Carlos Doki (carlosdoki@gmail.com)

#hack for centos docker bug
RUN mkdir -p /run/lock
RUN mkdir -p /arquivos

#JDK
ADD jdk-7u80-linux-x64.rpm /arquivos
RUN rpm -Uvh /arquivos/jdk-7u80-linux-x64.rpm

RUN rm -Rf /arquivos
ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin

# Prepare appdynamics user and directory
RUN mkdir -p /appdynamics
RUN groupadd -r appdynamics
RUN useradd --create-home --gid appdynamics appdynamics

# Add JMeter and scripts
RUN mkdir -p /appdynamics/jmeter
RUN mkdir -p /appdynamics/jmeter/scripts
ADD /jmeter/ /appdynamics/jmeter/
ADD /scripts/ /appdynamics/jmeter/scripts/

# Add the startup script
ADD /start.sh /appdynamics/
RUN chmod a+x /appdynamics/start.sh

# Run the startup script
CMD /appdynamics/start.sh && tail -F /appdynamics/jmeter/scripts/jmeter.log

