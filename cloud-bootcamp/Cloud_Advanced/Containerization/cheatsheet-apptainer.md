
# Apptainer Basics
1. Installation 
   - To install Apptainer, please refer to https://apptainer.org/docs/admin/main/installation.html
     On Redhat/CentOS/Almalinux/Fedora/Rocklinux, run:
     ```
     sudo dnf install -y epel-release
     sudo dnf install -y apptainer
     ```
   - To run Apptainer as a non-root user, also need to install apptainer-suid
     ```
     sudo dnf install apptainer-suid
     ```
   
   - Note, on Alliance systems (e.g Cedar, Graham, etc. or any cloud VM with CVMFS mounted), Apptainer is available in the modules. So we just need to `module load` it. See below:

      ```
      # *** The following steps are only necessary on an Alliance system ***

        # Load the module
        module load apptainer
      
            # However if you haven't yet load the standard environmental modules, you should do it prior to Apptainer
            module load CcEnv StdEnv/2023
        
        # Note that on Alliance systems, /home is not allowed for submitting jobs so we change the work directory to /project/ACCOUNT_ID/USERNAME. 
        # Hint, simply run "id" it will show the default account name/ID for you (e.g. def-xxxx(#######)).
        # show your own id and group info:
          id 
      
        # change to /project/YOUR_DEFAULT_GROUP_ID/YOUR_USERNAME (e.g. cd /project/6001146/erming), or run directly the following command:
          cd /project/`id |awk -vRS=',' '/def-/{print}' | head -1 | awk -F'(' '{print $1}'`/`whoami`
           
        
        # check the current work directory
          pwd 
      
        # It's not recommended to run Apptainer on the login nodes so you'd better do it on a compute node with the interactive mode using "salloc", with the following parameters:
        # salloc --account=YOUR_DEFAULT_ACCOUNT_NAME --nodes=1
        (e.g. salloc --account=def-erming --nodes=1)
        # Replace --account value with your own Allocation Account
       
      ```

2. Apptainer basic operations
  ```
  # Pull an exiting image from Singularity repo
  apptainer pull shub://singularityhub/hello-world
  ls

    # or from a docker repo
    apptainer pull docker://godlovedc/lolcow
    ls

  # Run a container
    # Option A, run the (container image) file directly to perform its function
    ./hello-world_latest.sif

    # Option B, use singluarity/apptainer to run 
    apptainer run hello-world_latest.sif
    
    # Run a command from inside the container
    apptainer exec <image> <command line>
    apptainer exec hello-world_latest.sif cat /etc/os-release

    # Bind/Mount host directories, e.g.,
    apptainer exec -B /opt hello-world_latest.sif sh
       Apptainer> ls /opt

    # comparing to 
    apptainer exec hello-world_latest.sif sh
       Apptainer> ls /opt

  # Start a shell from the container image
  apptainer shell hello-world_latest.sif
    pwd
    ls

    id
    #(or from the host `apptainer exec hello-world_latest.sif id`)
    # The output should be something like: uid=30xxxx(erming) gid=30xxxx(erming) groups=30xxxx(erming),60xxxx(def-erming)

    # comparing to docker:
    docker exec -it CONTAINER /bin/sh  
    id 
    # The output should be something like: uid=0(root) gid=0(root) groups=0(root),10(wheel)
  # From the above comparison, we can see the key difference of the user/id between Apptainer and Docker

  # Build an image from sandbox
    # create a sandbox from an image
    apptainer build --sandbox /tmp/debian docker://debian:latest

    # make some changes to the sandbox, eg.
    cd /tmp/debian
    touch mytestfile
    ls
 
    # build a new image 
    apptainer build mydebian.sif /tmp/debian

    # create a container from the new image and see the change from inside the container
    apptainer run mydebian.sif
    Apptainer> ls /

  # Daemonize it (run at the backend as a daemon)
    apptainer instance start ./hello-world_latest.sif hello-world
    apptainer instance list
    apptainer instance stop hello-world
  ```

  # To Access GPU (on an Alliance system, e.g. Cedar)

    #change to /project/YOUR_DEFAULT_GROUP_ID/YOUR_USERNAME (e.g. cd /project/6001146/erming), or run directly the following command:
      cd /project/`id |awk -vRS=',' '/def-/{print}' | head -1 | awk -F'(' '{print $1}'`/`whoami`

    # switch to a compute node by using salloc (Note it's not recommended to run Singuarity from a login node)
    salloc --gres=gpu:1 --mem 1000 -n 4 -t 60 --nodes=1 --account=def-erming
    (#if there is not an image yet, run: apptainer pull shub://singularityhub/hello-world)

    # Access GPU with the --nv option 
    apptainer exec --nv hello-world_latest.sif /bin/bash

    # Check the GPU info
    Apptainer> nvidia-smi
    
  # To submit a slurm job  (on an Alliance system, e.g. Cedar)
    # Create a job script and name it apptainer_batch.sh
    
      bash -c 'cat > apptainer_batch.sh' << EOF
      #!/bin/bash
      #SBATCH -J apptainer_test
      #SBATCH -o apptainer_test.out
      #SBATCH -e apptainer_test.err
      #SBATCH -t 0-00:30
      #SBATCH -c 2
      #SBATCH --mem=4000
    
      # Perform some tasks, e.g., 
        apptainer exec hello-world_latest.sif cat /etc/os-release
      EOF
    
    # Then submit it
      sbatch --account=def-erming apptainer_batch.sh
      
      (Note: You need to replace the --account value to your own Allocation Account)
   
