# Remove MovieZtream Docker containers

CONTAINERS=`docker ps -a -q`
echo
echo "Removing AppDynamics Education containers..."
echo
echo $CONTAINERS
if [ -n "$CONTAINERS" ]
  then
    docker stop $CONTAINERS
fi
sleep 5
docker rm db-agent db  rt sv ui mz-load
docker rmi appdynamics/edu-movieztream appdynamics/edu-db-agent appdynamics/edu-jmeter
