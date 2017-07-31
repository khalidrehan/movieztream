#!/bin/bash

if [ -z "${APP_NAME}" ]; then
	export APP_NAME="MovieZtream";
fi

if [ -z "${CONTROLLER}" ]; then
	export CONTROLLER="192.168.56.91";
fi

if [ -z "${APPD_PORT}" ]; then
	export APPD_PORT=8090;
fi

if [ -n "${ui}" ]; then
		if [ -z "${NODE_NAME}" ]; then
			export NODE_NAME="UI-001";
		fi
		
		if [ -z "${TIER_NAME}" ]; then
			export TIER_NAME="mz_ui";
		fi                
fi

if [ -n "${sv}" ]; then
		if [ -z "${NODE_NAME}" ]; then
			export NODE_NAME="SV-001";
		fi
		
		if [ -z "${TIER_NAME}" ]; then
			export TIER_NAME="mz_sv";
		fi
 	
fi

if [ -n "${rt}" ]; then
		if [ -z "${NODE_NAME}" ]; then
			export NODE_NAME="RT-001";
		fi
		
		if [ -z "${TIER_NAME}" ]; then
			export TIER_NAME="mz_rt";
		fi
fi
export MACHINE_AGENT_OPTS="-Dappdynamics.controller.hostName=${CONTROLLER} -Dappdynamics.controller.port=${APPD_PORT} -Dappdynamics.agent.applicationName=${APP_NAME} -Dappdynamics.sim.enabled=true -Dappdynamics.docker.enabled=true";
export AGENT_OPTS="-Dappdynamics.controller.hostName=${CONTROLLER} -Dappdynamics.controller.port=${APPD_PORT} -Dappdynamics.agent.applicationName=${APP_NAME} -Dappdynamics.agent.tierName=${TIER_NAME} -Dappdynamics.agent.nodeName=${NODE_NAME}";
export JAVA_OPTS="${AGENT_OPTS} -Xmx512m -XX:MaxPermSize=128m -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager";
