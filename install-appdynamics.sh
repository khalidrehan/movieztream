#!/bin/bash

# Use container hostname for response files
sed -e "s/SERVERHOSTNAME/`hostname`/g" /install/response.varfile > /install/response.varfile.1
sed -e "s/SERVERHOSTNAME/`hostname`/g" /install/euem.varfile > /install/euem.varfile.1
chown appdynamics:appdynamics /install/*.varfile.1

# Install license file, if supplied
if [ -f /install/license.lic ]; then
	mkdir -p /appdynamics/Controller
	chown appdynamics:appdynamics /appdynamics/Controller/
        cp /install/license.lic /appdynamics/Controller/
	chown appdynamics:appdynamics /appdynamics/Controller/license.lic
	chmod 744 /appdynamics/Controller/license.lic
fi

# Run Controller install
chown appdynamics:appdynamics /install/controller_64bit_linux.sh
chmod 774 /install/controller_64bit_linux.sh
su - appdynamics -c '/install/controller_64bit_linux.sh -q -varfile /install/response.varfile.1'

# Run EUEM install
chown appdynamics:appdynamics /install/euem-64bit-linux.sh
chmod 774 /install/euem-64bit-linux.sh

# Modify JVM options to support EUM/Analytics
su - appdynamics -c '/install/euem-64bit-linux.sh -q -varfile /install/euem.varfile.1';
su - appdynamics -c '/appdynamics/Controller/bin/modifyJvmOptions.sh delete -Dappdynamics.controller.eum.analytics.service.hostName=analytics.api.appdynamics.com'
su - appdynamics -c '/appdynamics/Controller/bin/modifyJvmOptions.sh add -Dappdynamics.controller.eum.analytics.service.hostName=localhost:9080'
su - appdynamics -c '/appdynamics/Controller/bin/modifyJvmOptions.sh add -Dappdynamics.controller.eum.cloud.hostName=http://localhost:7001'
su - appdynamics -c '/appdynamics/Controller/bin/modifyJvmOptions.sh add -Dappdynamics.controller.eum.beacon.hostName=lbr'

# Stop Controller, EUEM and Analytics
su - appdynamics -c '/appdynamics/Controller/bin/stopController.sh'
su - appdynamics -c 'cd /appdynamics/EUEM/eum-processor;bin/eum.sh stop'
su - appdynamics -c 'cp /install/eum.properties /appdynamics/EUEM/eum-processor/bin'

echo "Installed AppDynamics Platform"
