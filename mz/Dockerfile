# install Java7 from http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.rpm

FROM centos:centos7

MAINTAINER Carlos Doki (carlosdoki@gmail.com)

#hack for centos docker bug
RUN mkdir -p /run/lock
RUN mkdir -p /arquivos

ADD unzip-6.0-13.el7.x86_64.rpm /arquivos
RUN rpm -Uvh /arquivos/unzip-6.0-13.el7.x86_64.rpm

#JDK
ADD jdk-7u80-linux-x64.rpm /arquivos
RUN rpm -Uvh /arquivos/jdk-7u80-linux-x64.rpm

ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin

#TOMCAT
ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.14
ENV CATALINA_HOME /tomcat


# INSTALL TOMCAT
ADD apache-tomcat-8.0.14.zip /arquivos
RUN unzip /arquivos/apache-tomcat-*.zip -d /
RUN rm -Rf /arquivos/apache-tomcat-*.zip
RUN mv /apache-tomcat* /tomcat
RUN cd /tomcat/bin;chmod +x *.sh
RUN rm -Rf /tomcat/conf/server.xml
RUN rm -Rf /tomcat/conf/tomcat-users.xml
ADD server.xml /tomcat/conf/
ADD tomcat-users.xml /tomcat/conf/

#Agent Install
ADD AppServerAgent.zip /
RUN unzip /AppServerAgent.zip -d /tomcat/appagent
RUN rm AppServerAgent.zip

#Machine Agent Install
ENV MACHINE_AGENT_HOME /machine_agent
ADD MachineAgent.zip /
ADD monitor.xml /
ADD analytics-agent.properties /
RUN unzip /MachineAgent.zip -d ${MACHINE_AGENT_HOME}
RUN mv /monitor.xml ${MACHINE_AGENT_HOME}/monitors/analytics-agent
RUN mv /analytics-agent.properties ${MACHINE_AGENT_HOME}/monitors/analytics-agent/conf
RUN rm MachineAgent.zip

RUN mkdir /apps
ADD apps /apps/
ADD startup.sh /
ADD env.sh /
ADD start-machine-agent.sh /
RUN chmod +x /startup.sh
RUN chmod +x /start-machine-agent.sh
RUN chmod +x /env.sh

# Install JMeter for load generation - we install into the /appdynamics
# directory because that is where the application expects jmeter to be. This
# is where it is installed in the load container.
ADD jmeter /appdynamics/jmeter
RUN chmod a+x /appdynamics/jmeter/bin/*.sh

RUN rm -Rf /arquivos

WORKDIR /


CMD ["/bin/bash","/startup.sh"]

EXPOSE 80	
EXPOSE 8080
EXPOSE 8009
