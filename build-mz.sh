#! /bin/bash

# Copy installation files and scripts to build MovieZtream image
cp AppServerAgent.zip mz
cp MachineAgent.zip mz

# Copy installation files to build db-agent container
cp dbagent.zip db-agent
cp jdk-7u80-linux-x64.rpm db-agent
cp unzip-6.0-13.el7.x86_64.rpm db-agent

cp jdk-7u80-linux-x64.rpm mz
cp apache-tomcat-8.0.14.zip mz
cp unzip-6.0-13.el7.x86_64.rpm mz

cp jdk-7u80-linux-x64.rpm jmeter

# Build MovieZtream image then tidy up
echo
echo "Building MovieZtream container (appdynamics/edu-movieztream)"
echo
(cd mz; docker build -t appdynamics/edu-movieztream .)
(cd mz; rm -rf MachineAgent.zip AppServerAgent.zip jdk-7u80-linux-x64.rpm apache-tomcat-8.0.14.zip unzip-6.0-13.el7.x86_64.rpm)

# Build db-agent image then tidy up
echo
echo "Building db-agent container (appdynamics/edu-db-agent)"
echo
(cd db-agent; docker build -t appdynamics/edu-db-agent .)
(cd db-agent; rm -rf dbagent.zip jdk-7u80-linux-x64.rpm unzip-6.0-13.el7.x86_64.rpm)

# Build JMeter load image
echo 
echo "Building JMeter load container (appdynamics/edu-jmeter)"
echo
(cd jmeter; docker build -t appdynamics/edu-jmeter .)
(cd jmeter; rm -rf jdk-7u80-linux-x64.rpm)
# Cleanup temp dirs
rm -rf .appdynamics
(cd mz;rm -rf apache-tomcat-8.0.14.tar.gz jdk-7u80-linux-x64.rpm)

# Remove dangling images left-over from build
if [[ `docker images -q --filter "dangling=true"` ]] 
then
	echo
	echo "Deleting intermediate containers..."
	docker images -q --filter "dangling=true" | xargs docker rmi -f;
fi

# Run the entire system

# First, run the mysql container and create the sakila database
echo "Starting the MovieZtream database on container: db..."
docker run -d --name db -e MYSQL_ROOT_PASSWORD="rootpass" mysql

# Next, run the db-agent container
echo "Starting the db-agent on contaioner: db-agent..."
docker run -d --name db-agent --link db:db  appdynamics/edu-db-agent

# Next, run the MovieZtream tomcat containers
echo "Starting MovieZtream application containers: rt, sv, ui..."
docker run -d --name rt -e rt=true appdynamics/edu-movieztream
docker run -d --name sv --link db:db -e sv=true appdynamics/edu-movieztream
docker run -d -p 80:80 --name ui --link sv:sv --link rt:rt  -e ui=true appdynamics/edu-movieztream

# lastly, run the JMeter load container
echo "Starting the JMeter load container: mz-load..."
docker run -d --name mz-load --link ui:ui appdynamics/edu-jmeter

echo
echo "Waiting for agents to register..."
echo
sleep 120
echo
echo "Starting the AppDynamics Machine Agents for MovieZtream containers..."
echo
docker exec -d rt /bin/bash -c /start-machine-agent.sh
docker exec -d sv /bin/bash -c /start-machine-agent.sh
docker exec -d ui /bin/bash -c /start-machine-agent.sh
docker exec -i db mysql -u root -prootpass < ./db-scripts/setup.sql
echo
echo "All containers started!"
echo
