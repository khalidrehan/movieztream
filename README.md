# AppDynamics Education Docker Containers
Docker containers for installing and running the AppDynamics Controller and Education application (MovieZtream). These containers allow you to install and run the complete system with persistent data for the controller database.

## Quick Summary
1. Install the AppDynamics Controller
2. Install Docker as per the instructions in the pre-session lab.
3. Add a valid controller license to directory where you unzipped this package. We'll call that the mz-docker directory. You can provision a trial license at portal.appdynamics.com
4. Edit the files <mz-docker>/mz/env.sh and <mz-docker>/db/env.sh with the address of AppDynamics Controller and ports.
5. Edit the controller-info.xml in the Agents files with AccountAccess Key.
6. From a command line, change to the mz-docker directory and run build-mz.sh 
   This will build and start everything. The first time you build the system, it will ask you to log into AppDynamics.com and it will download all AppDynamics platform components as well as all relevant Docker images. This can take about 30 minutes.
7. Once the system is up, you can access the controller and the MovieZtream application with the URLs indicated in the pre-session lab instructions.
8. To stop the system while preserving controller database state, in a command line, change to the mz-docker directory and run stop-mz.sh. This will stop all the docker containers.
9. To re-start the system, in a command line, change to the mz-docker directory and run start-mz.sh. This will re-start all the docker containers
10. To remove all the containers permanently, in a command line, change to the mz-docker directory and run remove-mz.sh. This will remove all the MovieZtream and AppDynamics docker containers, and it will erase the controller database.

## To access the MovieZtream UI (to change load conditions) you can go to
http://DOCKER_HOST/movieztream_ui where DOCKER_HOST is the value of the DOCKER_HOST environment variable, or, if you have
edited your /etc/hosts file as per the instructions, you can use
http://localdocker/movieztream_ui

The MovieZtream credentials are: HOLLY / FOX or DON / BONE

Enjoy!
