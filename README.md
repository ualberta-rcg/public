###### Welcome to the public space of the Research Support Group at the University of Alberta

## HPC carpenrty 4
#### What to do when you run into problems. Interactive use, first steps in debugging, tunning, and profiling.

The intent of this workshop is to follow HPC carpentry pedagogy and continue on from where the HPC carpentry typically ends.
Using HPC resources is a challenging topic to a new user and best practices or what to do when a new user runs into problems get cut. This is made worse when the participant does not have a good foundation using the Unix operating system environment.  This results in being participants getting being able to use a cluster until they run into the first problem. 



##### This document will include instructions on how to do the demos that go along with the presentation and includes most of the value component of the workshop particpant. 

1. Log in to the Cluster have your workshop participants do the same and open 3 separate windows.
 `ssh user98@training.uofa.c3.ca -X`
1. Have the class run script to capture all the input and output in the workshop. Mention the utility of using this program for support requests. 
`script hpc4-worskshop.txt`
1. Let us look on the server/node we are logged in on, `hostname` and the location `pwd` 
1. Look at the node types on this cluster  `sinfo  -o "%N %m"`
1. Let us an interactive job `salloc `  please note that the prompt has changed and we are  logged in: `hostname` and the location `pwd` 
1. Explore the environment by printing the environment variables `printenv` let's look at only the slurm variables `printenv | grep -i slurm` or just the ones that start with SLURM_JOB `printenv | grep -i SLURM_JOB`
1. How much memory are we allowed to use `printenv | grep -i slurm | grep -i mem` shows no memory enviorment variable but if we ask slurm how much our job is using `squeue -u $USER` we see a small default of 256MB. Lets exit the interactive job with `the exit command or ctrl-D `
1. Lets us run an interactive job asking for 5000MB of memory `salloc --mem=5000`, how much memory can we use now. `printenv | grep -i slurm | grep -i mem` now shows an environment variable `SLURM_MEM_PER_NODE=5000` querying slrum `squeue -u $USER` shows 5000MB of allocated memory
 
1. Demo of processes and the commands to look at them: (ps, pstree, top htop).
1. Demo of putting a process into foreground and background: (fg,bg,jobs,&) 
1. Demo of looking at the memory: (free, top, htop,/etc/proc/meminfo) 
1. Make a note of the job id:  `echo $SLURM_JOB_UID`, open the other window we are logged on in the cluster and attach to the job `srun --jobid=<jobid> --pty bash` verify that we are in the same node the job `echo $SLURM_JOB_UID`, `hostname` run the `top` command

1. Octave is a free version a Matlab like modelling tool used by many researchers and Engineers,interactively.  Let's load it in the original session first load the environment: `module spider octave`, `module load nixpkgs/16.09` ,`module load gcc/5.4.0`,`module load intel/2017.1`,`module load octave/4.2.1`
1. Start octave `octave` we will create a couple of vectors and plot them `a=[0:0.5:5]`, `b=2*a.^2+ 6*a`, `plot(a,b) ` if you have graphics (X11) forwarded on you will see a graph window pop up otherwise it will be shown in the text window.  
1. Now we will create 2 very large vectors and do some simple math on them, and switch to the other window running top to see the memory being allocated and the computations take place. 

1. If we were using a GPU we could replace top with "watch -n 0.5 nvidia-smi" to look at GPU statistics

1. Demo the IO querying commands: df, lsof -p,lsof -u,quota,dstat,IOstat, Htop
1. Demo some advanced diagnostics: sar, perf 
1. (Advanced) You need to be on the same node/server as your running program to debug it. By running interactively we can debug your program by running a debugger. This is mostly beyond the scope of the session and can be its own workshop. (To do put simple instruction on how to demo running a debugger).
1. Demo `netstat` network diagnosis tool. 

