#!/bin/bash
CWD=${PWD}

if [ -z "${CONTROLLER}" ]; then
	export CONTROLLER="192.168.56.91";
fi

if [ -z "${APPD_PORT}" ]; then
	export APPD_PORT=8090;
fi

JAVA_OPTS="-Dappdynamics.controller.hostName=${CONTROLLER} -Dappdynamics.controller.port=${APPD_PORT}";

JAVA_OPTS="${JAVA_OPTS} -Xmx512m -XX:MaxPermSize=128m";

echo $JAVA_OPTS;

cd ${CATALINA_HOME}/bin;

java ${JAVA_OPTS} -jar ${AGENT_HOME}/db-agent.jar

cd ${CWD}
