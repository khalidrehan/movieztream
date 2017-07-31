echo "Starting Machine Agent..."
source /env.sh
echo java ${MACHINE_AGENT_OPTS} -jar ${MACHINE_AGENT_HOME}/machineagent.jar
nohup java ${MACHINE_AGENT_OPTS} -jar ${MACHINE_AGENT_HOME}/machineagent.jar  > ${MACHINE_AGENT_HOME}/machine_agent.log 2>&1 &
