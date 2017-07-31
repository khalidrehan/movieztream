#! /bin/bash

echo
echo "Stopping all containers..."
echo
docker stop mz-load
docker stop ui
docker stop sv
docker stop rt
docker stop db-agent
docker stop db
echo
echo "All containers stopped!"
echo

