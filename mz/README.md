Docker image for the Inventory-Server, Order-Processing-Server and ECommerce-Server tiers of the ECommerce demo, based on the [ecommerce-java](https://github.com/Appdynamics/ECommerce-Docker/blob/master/ECommerce-Java/Dockerhub.md) base image.

The ECommerce-Java demo images use the following infrastructure services, which should be started before running the images for the various demo tiers: 

1. [ecommerce-activemq](https://github.com/Appdynamics/ECommerce-Docker/blob/master/ECommerce-ActiveMQ/Dockerhub.md): e.g. `docker run --rm -it --name jms appdynamics/ecommerce-activemq`
2. [mysql](https://registry.hub.docker.com/_/mysql/): e.g. `docker run --name db -e MYSQL_ROOT_PASSWORD=singcontroller -d mysql`

For communication between the various tiers, it is important to [link the containers](https://docs.docker.com/userguide/dockerlinks/) correctly, as shown in the following examples.  These assume that the MySQL service has been started with `--name db` and the ActiveMQ service with `--name jms`.  These services then need to be available to the various demo tiers with `--link db:db --link jms:jms`.

To access a service from outside the docker container, use the docker run `--port` option, like this: `-p 8080:8080` which will make port 8080 in the image reachable via port 8080 in the local docker container.  If running on OSX/Windows using [boot2docker](http://boot2docker.io/), you can find the address of the local docker container with `boot2docker ip`.  You can map the port to your `localhost` interface using VBoxManage like this: `VBoxManage controlvm boot2docker-vm natpf1 "8080-8080,tcp,127.0.0.1,8080,,8080"`

For the **Inventory-Server** set `-e ws=true`, e.g.

`docker run --rm -it --name ws -e ws=true --link controller:controller --link db:db --link jms:jms appdynamics/ecommerce-tomcat`

For the **Order Processing Server**, set `-e jms=true`, e.g.

`docker run --rm -it --name msg -e jms=true --link controller:controller --link db:db --link jms:jms appdynamics/ecommerce-tomcat`

For the **ECommerce-Server** set `-e web=true`, e.g.

`docker run --rm -it --name web -e web=true -p 8080:8080 --link controller:controller --link db:db --link ws:ws --link jms:jms appdynamics/ecommerce-tomcat`

To connect the demo tiers to your AppDynamics Controller, you have two options:

1. Run the controller in a local docker container: by default, the agent will try to register with a controller running on `controller:8090`, so run the controller in your local docker container with `--name controller` and then link to it like this: `--link controller:controller`
2. Connect to a hosted controller (e.g. AWS or SaaS) using comandline environment variables like this: `-e CONTROLLER=pm2.appdynamics.com -e APPD_PORT=80`

See the [startup script](https://github.com/Appdynamics/ECommerce-Docker/blob/master/ECommerce-Tomcat/startup.sh) for details of the various startup env options available.
