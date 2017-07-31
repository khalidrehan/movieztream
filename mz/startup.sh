#!/bin/bash
CWD=${PWD}

source /env.sh

if [ -n "${ui}" ]; then
        cp /apps/movieztream_ui.war /tomcat/webapps;
fi

if [ -n "${sv}" ]; then
 	cp /apps/movieztream_service.war /tomcat/webapps;
fi

if [ -n "${rt}" ]; then
        cp /apps/movieztream_rating.war /tomcat/webapps;
fi

echo $JAVA_OPTS;

cd ${CATALINA_HOME}/bin;

java -javaagent:${CATALINA_HOME}/appagent/javaagent.jar ${JAVA_OPTS} -cp ${CATALINA_HOME}/bin/bootstrap.jar:${CATALINA_HOME}/bin/tomcat-juli.jar org.apache.catalina.startup.Bootstrap

cd ${CWD}
