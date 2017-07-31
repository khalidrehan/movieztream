#! /bin/bash

# start the load to MovieZtream
cd /appdynamics/jmeter/scripts
nohup /appdynamics/jmeter/bin/jmeter.sh -n -l jmeter.log -t ./mz-java.jmx &

sleep 30
echo "Finished startup script..."
