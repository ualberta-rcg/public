Description: The Cloud Advanced session is a variable session that aims to accommodate different topics of advanced cloud technologies & applications, including Openstack Heat, Dokku, HPC on cloud, etc. In this bootcamp, we will demonstrate how to use Openstack Heat to rapidly deploy cloud services and applications (e.g. create a service stack for hosting a Nginx based web service).
Note: The following instruction is based on CentOS Linux. To be updated for other OSes/flavors.

Preparation:
In order to run Openstack Heat, we need to set up the computing environment first including python/PIP, Openstack client and Heat client.

1. Install python and PIP

  - On Linux :

    `yum install python3`


2. Use PIP to install python-openstackclient and python-heatclient

    ```
    pip install python-openstackclient
    pip install python-heatclient
    ```

3. Download the Openstack client setup script from Arbutus

    1. Log on to https://arbutus.cloud.computecanada.ca/
    2. At the top right corner, click on your account name
    3. In the drop-down menu, click on "Openstack RC file V3"
    4. A guestxxx-openrc.sh file will be downloaded to your computer
 
4. Source the downloaded guestxxx-openrc.sh file on your computer to set up your Openstack client:

    `source guestxxx-openrc.sh`
    
5. Verify the client env with running:

    `openstack stack list`
    
   If now errors it means your openstack client env is correctly set up. 
   
6. Check Openstack resources such as flavors, images, network, security group, key, etc.
   Basically you can run "openstack -h|grep list" to retrieve all the listing commands, such as:
   
   ```
   openstack flavor list
   openstack image list
   openstack network list
   openstack keypair list
   openstack security group list
   openstack stack list
   ```
   
7. Create your first Heat template, e.g.:
   ```
   heat_template_version: 2015-04-30

   description: A simple template to deploy a basic instance

   resources:
     my_instance:
       type: OS::Nova::Server
       properties:
         key_name: heat_key
         image: CentOS-7-x64-2019-07
         flavor: p1-1.5gb 
         networks:
           - network: erming-net-1 
         security_groups:
           - default
   ```
   Save it as a file with extension .yaml (e.g.: ~/simplest.sh)
   
 8. Create your first stack with the template:
 
    Syntax:
    
    `openstack stack OPERATION OPTION STACK_NAME`
    
    For example:
    
    `openstack stack create -t ~/simplest.sh simplest`
     
 9. Check the stack status:
    
    `openstack stack show simplest`
    
    You can also check a certain `resource` in the stack:
    
    `opensteack stack resource list`
    `openstack stack resource show STACK_NAME RESOURCE_NAME`
    
10. To update a stack after applied some changes to the template:
  
    `openstack stack update -t HEAT_TEMPLATE STACK_NAME`
    
11. Other Heat (or stack) operations:
  
    ```
    # To suspend a stack
    openstack stack suspend STACK_NAME
    # To resume a stack
    openstack stack resume STACK_NAME
    # To delete a stack
    openstack stack delete STACK_NAME
     
    ```
    
    













