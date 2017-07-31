#! /bin/bash

# Start the db container
echo
echo "Starting the MySQL database container..."
echo
docker start db
sleep 10

# Start the db-agent container
echo
echo "Starting the AppDynamics db agent container..."
echo
docker start db-agent

# Start the MovieZtream containers in the correct order
echo
echo "Starting the MovieZtream ratings container..."
echo
docker start rt
sleep 10
echo
echo "Starting the MovieZtream service container..."
echo
docker start sv
sleep 10
echo
echo "Starting the MovieZtream UI container..."
echo
docker start ui
sleep 30

# Start the JMeter load container
echo
echo "Starting the JMeter load container..."
echo
docker start mz-load
echo
echo "Waiting for agent registration..."
echo
sleep 60

echo
echo "Starting AppDynamics machine agents on MovieZtream containers..."
echo
docker exec rt /bin/bash -c /start-machine-agent.sh
docker exec sv /bin/bash -c /start-machine-agent.sh
docker exec ui /bin/bash -c /start-machine-agent.sh

echo
echo "All containers started! You can access the AppDynamics Controller at $DOCKER_HOST:8090"
echo

