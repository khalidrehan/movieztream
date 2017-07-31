Runs the DBAgent process for the ECommerce demo.  First start the database with: `docker run --name db -e MYSQL_ROOT_PASSWORD=singcontroller -d mysql`, then run the DBAgent like this:

`docker run -d --link db:db --link controller:controller appdynamics/ecommerce-dbagent` 

To connect the demo tiers to your AppDynamics Controller, you have two options:

1. Run the controller in a local docker container: by default, the agent will try to register with a controller running on controller:8090, so run the controller in your local docker container with `--name controller` and then link to it like this: `--link controller:controller`
2. Connect to a hosted controller (e.g. AWS or SaaS) using comandline environment variables like this: `-e CONTROLLER=pm2.appdynamics.com -e APPD_PORT=80`

See the [startup script](https://github.com/Appdynamics/ECommerce-Docker/blob/master/ECommerce-DBAgent/startup.sh) for details of the various startup env options available.
