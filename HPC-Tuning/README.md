###### Welcome to the public space of the Research Support Group at the University of Alberta

## HPC carpenrty 4
#### What to do when you run into problems. Interactive use, first steps in debugging, tunning, and profiling.

The intent of this workshop is to follow HPC carpentry pedagogy and continue on from where the HPC carpentry typically ends.
Using HPC resources is a challenging topic to a new user and best practices or what to do when a new user runs into problems get cut. This is made worse when the participant does not have a good foundation using the Unix operating system environment.  This results in being participants getting being able to use a cluster until they run into the first problem. 



##### This document will include instructions on how to do the demos that go along with the presentation and includes most of the value component of the workshop particpant. 

1. Preperation:
     1. Log in to the Cluster have your workshop participants do the same and open 3 separate windows.
        `ssh user98@spring2022-uofa.c3.ca -X`
     1. Create a interactive directory we will be working here: `mkdir interactive`
     1. Enter the newly created directory on both sessions:  `cd interactive`
     1. Download the cryptic program: `wget https://github.com/ualberta-rcg/public/raw/master/HPC-Tuning/cryptic`
     1. List the current directory: `ls -al`
     1. make the cryptic program exactable: `chmod u+x ./cryptic`
     1.  List the current directory, crypric should be executable: `ls -al`
     1. Have the class run script to capture all the input and output in the workshop. Mention the utility of using this program for support requests. 
`script hpc4-worskshop.txt`

1. Interactive 
    1. Let us look on the server/node we are logged in on, `hostname` and the location `pwd` 
    1. Look at the node types on this cluster  `sinfo  -o "%N %m"`
    1. Let us an interactive job `salloc `  please note that the prompt has changed and we are  logged in: `hostname` and the location `pwd` 
    1. Explore the environment by printing the environment variables `printenv` let's look at only the slurm variables `printenv | grep -i slurm` or just the ones that start with SLURM_JOB `printenv | grep -i SLURM_JOB`
    1. How much memory are we allowed to use `printenv | grep -i slurm | grep -i mem` shows no memory enviorment variable but if we ask slurm how much our job is using `squeue -u $USER` we see a small default of 256MB. Lets exit the interactive job with `the exit command or ctrl-D `
    1. Lets us run an interactive job asking for 5000MB of memory `salloc --mem=5000`. If the job will not run because of memory, check memory availability by running `sinfo -o :%N %m"` iteractivly run requesting all the memory on the node. Check how much memory can we use now. `printenv | grep -i slurm | grep -i mem` now shows an environment variable `SLURM_MEM_PER_NODE` or querying slurm `squeue -u $USER` shows allocated memory.
1. Second interactive session     
    1. In the first interactive session make a note of the job id of the running job:  `echo $SLURM_JOB_UID` or `squeue -u $USER`
    1. In the third window we will join an allready runing job with another session.
      1. Run the hostname command `hostname`, and echo $SLURM_JOB_UID` to show we are on the login node and not in a job. 
      1. Join the allready running job by attaching to the allready running job: `srun --jobid=44 --pty bash`
      1. Verify that we are inside the allready running job:  `echo $SLURM_JOB_UID`
      1. Verify that we are on the same node as the job is running on: `hostname`
      1. Run the top command: `top -u $USER`
      1. Check how much memory can we use now. `printenv | grep -i slurm | grep -i mem`
      1. Run the printenv command: `printenv | grep -i slurm ` 
      1. Exit the secone interactive session: `exit`
      1. Exit the third window: `exit` 
   
1. System commands
    1. Demo of processes and the commands to look at them: (ps, pstree, top htop).
    1. Demo of putting a process into foreground and background and nohup: (fg,bg,jobs,&,nohup) 
    1. Demo of looking at the memory: (free, top, htop,/proc/meminfo) 
    1. Make a note of the job id:  `echo $SLURM_JOB_UID`, open the other window we are logged on in the cluster and attach to the job `srun --jobid=<jobid> --pty bash` verify that we are in the same node the job `echo $SLURM_JOB_UID`, `hostname` run the `top` command

1. Demo memory use and observation
   1. In a interactive session run octave, in the second window run top
     1. Run an interactive job: `salloc --mem=5000`
     1. In the second window join the job: `srun --jobid=44 --pty bash`
     1. In the second window run top 
     1. Octave is a free version a Matlab like modelling tool used by many researchers and Engineers,interactively.  Let's load it in the original session first load the environment: `module spider octave`, `module load octave/5.2.0`, `module list octave`
     1. Start octave in the first window: `octave` 
     1. Create a couple of vectors and plot them: `a=[0:0.5:5]`, `b=2*a.^2+ 6*a`
     1. Add all the numbers in the vectors together: `c= a .+ b`  
     1. We will create a very large vectors: `d=[0:1:10000000];`, `d(1:20)`
     1. Did you notice the memory usage inrease in top?
     1. We will create a second very large vectors: `e=[0:1:10000000];`, `e(1:20)`
     1. We will now perform computation on the two vectors:  `f= e.* d;`,`f(1:20)` 
     1. Did you notice the cpu usage whnet up in top?
   

1. Demo GPUs on Digital research alliance of Canada resources:
     1. Log onto a DRAC cluster: `ssh username@cedar.computecanada.ca`
     1. Sumbmit an interactive gpu job: `salloc --gres=gpu:1`
     1. Join the interactive job with another: srun --jobid=44 --pty bash
     1. Look at the status of the GPU: "watch -n 0.5 nvidia-smi" instead of or in addition to top to look at GPU statistics

1. Demo IO commands
     1. Demo the IO querying commands: df, lsof -p,lsof -u,quota,dstat,IOstat, Htop
     1. Demo `netstat` network diagnosis tool. 

1. Class exercise  
     1. Have the participants run the cryptic program downloaded at the start of the session 
     2. Hint: you need to use a compute node.  
     3. Run the program interactivly and figure out how much memory this program requires. 

1. To Do: Create more exaples like cryptic  
1. To Do: Create a example that does a lot of IO and  small amount of compute. 
1. To Do: Create a GPU example
