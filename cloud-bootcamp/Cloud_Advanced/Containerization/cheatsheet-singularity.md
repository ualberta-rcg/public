
On the Alliance systems (e.g Cedar, Graham, etc.), Singularity is already installed and set up for users. So just module load it. 
```
  # Load the module
  module load singularity
  
  # However if you haven't yet load the standard environmental modules, you should do it prior to Singularity
  module load CcEnv StdEnv/2020
  
  # Note that on Cedar/etc system, it's not recommended to run Singularity on the login nodes so better do it on a compute node with the interactive mode
  salloc --account=def-erming --nodes=1
```

Singularity basic operations
```
  # Pull an exiting image from Singularity repo
  singularity pull shub://singularityhub/hello-world
  ls

    # or from a docker repo
    singularity pull docker://godlovedc/lolcow
    ls

  # Run a container
    ./hello-world_latest.sif
    singularity exec hello-world_latest.sif
    
    # Run a command from inside the container
    singularity exec <image> <command line>
    singularity exec hello-world_latest.sif cat /etc/os-release

    # Bind/Mount host directories, e.g.,
    singularity exec -B /home -B /tmp hello-world_latest.sif

  # Start a shell from the container image
  singularity shell hello-world_latest.sif
    pwd
    ls

    id
    (or from the host `singularity exec hello-world_latest.sif id`)
    uid=30xxxx(erming) gid=30xxxx(erming) groups=30xxxx(erming),60xxxx(def-erming)

    # comparing to docker:
    $ docker run busybox id
    uid=0(root) gid=0(root) groups=0(root),10(wheel)

  # Build an image from sandbox
  singularity build --sandbox /tmp/debian docker://debian:latest
  singularity exec --writable /tmp/debian apt-get install python
  singularity build /tmp/debian2.sif /tmp/debian


  # Daemonize it (run at the backend as a daemon)
  singularity instance start ./hello-world_latest.sif hello-world
  singularity instance list
  singularity instance stop hello-world

  # To Access GPU
   
    # switch to a compute node by using salloc (Note it's not recommended to run Singuarity from a login node)
    salloc --gres=gpu:1 --mem 1000 -n 4 -t 60 --nodes=1 --account=def-erming
    (#if there is not an image yet, run: singularity pull shub://singularityhub/hello-world)

    # Access GPU with the --nv option 
    singularity exec --nv hello-world_latest.sif /bin/bash

    # Check the GPU info
    Singularity> nvidia-smi
    
  # To submit a slurm job

    #Create a job script and name it sigularity_batch.sh
    #!/bin/bash
    #SBATCH -J singularity_test
    #SBATCH -o singularity_test.out
    #SBATCH -e singularity_test.err
    #SBATCH -t 0-00:30
    #SBATCH -c 1
    #SBATCH --mem=4000
    
    # Perform some tasks, e.g., 
    singularity exec hello-world_latest.sif cat /etc/os-release

    # and then submit it
    sbatch sigularity_batch.sh
   

```