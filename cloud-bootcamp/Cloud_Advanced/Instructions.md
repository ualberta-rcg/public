Description: The Cloud Advanced session is a variable session that aims to accommodate different topics of advanced cloud technologies & applications, including Openstack Heat, Dokku, HPC on cloud, etc. In this bootcamp, we will demonstrate how to use Openstack Heat to rapidly deploy cloud services and applications (e.g. create a service stack for hosting a Nginx based web service).

Note: The following instruction is based on CentOS Linux. To be updated for other OSes/flavors.

Preparation:

In order to run Openstack/Heat commands, we need to set up the computing environment first including python/PIP, Openstack client and Heat client.

1. Install python3 and pip (Note: pip is a plugin of python. Once you get python installed, you will be able to use pip).

  - On CentOS Linux :

    `yum install python3`
    
  - On Ubuntu:
   
    `apt-get update`
    
    `apt-get install python3`
    
  - On Mac OS:
  
    `brew install python3`
    
    If you don't have brew installed, you may do it now with running:
    
    `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`

  - On Windows, you need a termial with ssh client installed, or I will guide you to use the web based options so you can skip the python/etc installations.


2. Use PIP to install python-openstackclient and python-heatclient

    ```
    pip3 install python-openstackclient
    pip3 install python-heatclient
    ```

3. (Optional) If you found some software/library conflicts with existing ones on your OS, you may use virtualenv to set up a virtual environment, by running:

    ```
    python3 -m venv guest5xxenv 
    source guest5xxenv/bin/activate
    ```
   From where you can run the above commands safely. 

   (To quit the virtual env, you may run `deactivate`)
  
4.  Download the Openstack client setup script from Arbutus

    1. Log on to https://arbutus.cloud.computecanada.ca/
    2. At the top right corner, click on your account name
    3. In the drop-down menu, click on "Openstack RC file V3"
    4. A def-training-cloudbootcamp.sh file will be downloaded to your computer
 
4. Source the downloaded guestxxx-openrc.sh file on your computer to set up your Openstack client:

    `source def-training-cloud-openrc.sh`
    
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
   ```
   
7. Create a key pair for Heat
   ```
   openstack keypair create guest5XX_keypair > guest5xx_key.priv
   chmod 400 guest5xx_key.priv
   ```
   
8. Create your first Heat template, e.g.:
   ```
   heat_template_version: 2015-04-30

   description: A simple template to deploy a basic instance

   resources:
     guest5xx_vm:  # Resource name. Replace it with your guest account name, or any random name
       type: OS::Nova::Server
       properties:
         key_name: guest5xx_keypair   # Your key pair name 
         image: CentOS-7-x64-2021-11
         flavor: p1-1.5gb 
         networks:
           - network: def-training-cloud-network 
         security_groups:
           - default
   ```
   Save it as a file with an extension .yaml (e.g.: simple.yaml)
   
 9. Create your first stack with the template:
 
    Syntax:
    
    `openstack stack OPERATION OPTION STACK_NAME`
    
    Example 1:
    
    `openstack stack create -t simple.yaml guest500_stack`
     
10. Check the stack status:
    
    `openstack stack show guest500_stack`
    
    You can also check a certain `resource` in the stack:
    
    `opensteack stack resource list`
    `openstack stack resource show STACK_NAME RESOURCE_NAME`
    
11. To update a stack after applied some changes to the template:
  
    `openstack stack update -t HEAT_TEMPLATE STACK_NAME`
    
    Example 2:
    
    `openstack stack update -t nginx.yaml guest500_stack`
    
    Example 3:
    
    `openstack stack update -t nginx_tetris.yaml guest500_stack`
    
    Note: The above yaml files can be found on github under `public/cloud-bootcamp/Cloud_Advanced` .

    
12. Other Heat (or stack) operations:
  
    ```
    # To suspend a stack
    openstack stack suspend STACK_NAME
    # To resume a stack
    openstack stack resume STACK_NAME
    # To delete a stack
    openstack stack delete STACK_NAME
     
    ```















