###### Welcome to the public space of the Research Support Group at the University of Alberta

## HPC cluster/unix tools
#### This session will teach you how to run and control programs understand what is happening, and diagnose some problems on Unix/Linux systems

High performance computing (HPC) clusters are composed Linux machines, understanding and controlling work on a cluster is extension of the skills in doing the same on a Linux machine. 
You will learn how to tell how much memory, how many open files, how much disk IO, Iops, network traffic does a program use. 
How to tell much resources exist on a computer and how busy it is currently and which program are using these resources. 
We will then extend the same tools and techniques for jobs running on a cluster.

The slides for this workshop can be found [here](https://docs.google.com/presentation/d/10Y2fqe_PwdxbOybSsY7SvRP1wjl8ksblmyyoALSWXGI/edit?usp=sharing)

1. Preperation:
    1. Log in to the Cluster: `ssh user98@training.uofa.c3.ca -X`
    1. Create a tools directory and cd into into it: `mkdir tools`, `cd tools`
    1. Download the cryptic program: `wget https://github.com/ualberta-rcg/public/raw/master/HPC-Tuning/cryptic`
    1. make the cryptic program exactable: `chmod 700 ./cryptic`

1. Working with Tmux
    1. Open a session new tmux session: `tmux new -s tools`
    1. Split the pane horizontaly: `Ctrl-b "`
    1. In the bottom pane run the top analysis command: `Ctrl-b downarrow`, `top -u $USER
    1. Go the top plane run script program: `Ctrl-b upparrow`
    1. Run the cryptic program watch what happens in top: `cryptic`
    1. Create a new window in tmux: `Ctrl-b c`
    1. Run pstree comand: `pstree -u $USER`
    1. Change back to the original window: `Ctrl-b w`
    1. Run the ps command: `ps`
    1. Detach from the session: `ctrl-b d`
    1. list the tmux sessions: `tmux ls`
    1. (Optional) Log out of the text cluster, log back in, go back to the tools directory list tmux sesions: `exit`,`ssh training.uofa.c3.ca -X`,`cd tools` ,`tmux ls`
    1. Reattach to the tmux session: `tmux -t tools`
    1. Verify that your session is still running.
    1. You can choose to close tmux by killing all the windows: `Crl-b &`

1. Working with script 
    1. Run script: `script lesson.txt`
    1. Run the df coammnad: `df`
    1. Exit the script either `exit`, `Ctrl-d`
    1. Display the output of the script file: `cat lesson.txt`
    1. Start script again and appand to the original script file" `script -a lesson.txt`
    1. Dispaly all the enviorment variables: `printenv` 
    1. Exit the script either `exit`, `Ctrl-d`
    1. Display the output of the script file: `cat lesson.txt`

1. For the rest of the session you may need multiple windows, either log in as multiple windows or use tmux. 
   You may also want to save a record of the lesson with script.

1. Working with processes
   1. Run the ps command: `ps`, `ps -ef`, `ps aux`
   1. List the current shells process id: `echo $$`
   2. Run the pstree command: `pstree`
   3. Run the top command: `top
   4. Run the htop command: `htop` 
 
1. Working with Threads
   1. Run the ps command: `ps -T`
   1. Run the pstree command: `pstree -p`
   1. Run the htop command: `htop -H`  

1. Working with Process Groups and Jobs
   1. Run the sleep program to sleep 3 seconds: `sleep 3` wait until it is done
   1. Run the sleep program to sleep 3 seconds in the background: `sleep 3 &` wait until it is done
   1. Run the sleep program to sleep 1000 seconds in the background: `sleep 1000 &` note its process id and job id
   1. Run the sleep program to sleep 1200 seconds in the background: `sleep 1200 &`
   1. Run the sleep program to sleep 1300 seconds: `sleep 1300`
   1. Suspend the sleep command with a `Ctrl-d
   1. Run the ps command: `ps -ja` to see the process groups
   2. List all the jobs in the background: `jobs` 
   3. Contiue running the suspended process in the background: `bg %X
   4. List all the jobs in the background: `jobs` 
   5. Kill the job that sleeps for 1300: `kill %X`
   6. Kill the first sleep command by its process id: `kill <pid>`
   7. Kill the remaining job by its process group `kill -<pgid>`
   
1. Memory
   1. You may wish to have 2 windows or panels open for this  
   1. Run the follwoing commands (`free -m`,`cat /proc/meminfo`) command to see how much memory is on the system 
   1. Run top and htop commands see to see how much memory is free, available is swap being used?
   1. Run the cryptic program how much memory does it use, what is going on on the cluster as multple people run it? 

1. Scheduler  
   1. nice
   1. priority 
   
1. Cgroups
   1. /sys/fs/cgroup    
  
1. Signals
   1. Demo `Ctrl-c`
   1. Demo `Ctrl-z`
   1. Killing a program that will not die, assume that the next program is refusing to die
   1. Open the manual for the ps command `man ps`
   1. Suspend the process and put it into the background `Ctrl d`
   1. Run the ps command to find the processses id: `ps`
   1. Send the SIGKILL signal to the process `kill -SIGKILL <ps>`
   
 1. Disk and Network IO
    1. Run the commands to see system IO usage: `dstat`, `iostat`, `iotop`
    1. Run `lsof` to see the number of open files. 
    1. Run the commands to see dfisk usage per process: `pidstat -d`, `htop`
 
1. Process state statistics
    1. Run the commands to see state of processes on this machine: `htop`, `top`, `dtsat`
    1. The ipdstat command shows you the same information on a per proccess basis: pidstat -u -U $USER 
   
1. Clustertools   
   1. Look at the node types on this cluster  `sinfo  -o "%N %m"`
   1. Let us an interactive job `salloc `  please note that the prompt has changed and we are  logged in: `hostname` and the location `pwd` 
   1. Explore the environment by printing the environment variables `printenv` let's look at only the slurm variables `printenv | grep -i slurm` or just the ones that start with SLURM_JOB `printenv | grep -i SLURM_JOB`
   1. How much memory are we allowed to use `printenv | grep -i slurm | grep -i mem` shows no memory enviorment variable but if we ask slurm how much our job is using `squeue -u $USER` we see a small default of 256MB. Lets exit the interactive job with `the exit command or ctrl-D `
   1. Lets us run an interactive job asking for 5000MB of memory `salloc --mem=5000`. If the job will not run because of memory, check memory availability by running `sinfo -o :%N %m"` iteractivly run requesting all the memory on the node. Check how much memory can we use now. `printenv | grep -i slurm | grep -i mem` now shows an environment variable `SLURM_MEM_PER_NODE` or querying slurm `squeue -u $USER` shows allocated memory.

   1. Make a note of the job id:  `echo $SLURM_JOB_UID`, open the other window we are logged on in the cluster and attach to the job `srun --jobid=<jobid> --pty bash` verify that we are in the same node the job `echo $SLURM_JOB_UID`, `hostname` run the `top` command

   1. Octave is a free version a Matlab like modelling tool used by many researchers and Engineers,interactively.  Let's load it in the original session first load the environment: `module spider octave`, `module load nixpkgs/16.09` ,`module load gcc/5.4.0`,`module load intel/2017.1`,`module load octave/4.2.1`
   1. Start octave `octave` we will create a couple of vectors and plot them `a=[0:0.5:5]`, `b=2*a.^2+ 6*a`, `plot(a,b) ` if you have graphics (X11) forwarded on you will see a graph window pop up otherwise it will be shown in the text window.  
   1. Now we will create 2 very large vectors and do some simple math on them, and switch to the other window running top to see the memory being allocated and the computations take place. `d=[0:1:10000000];`, `d(1:20)`,`e=[0:1:10000000];`, `f= e.* d;`,`f(1:20)` 

   1. Demo grabing a gpu on a Compute Canada cluster. Use "watch -n 0.5 nvidia-smi" instead of or in addition to top to look at GPU statistics

1. Demo the IO querying commands: df, lsof -p,lsof -u,quota,dstat,IOstat, Htop
1. Demo some advanced diagnostics: sar, perf 
1. (Advanced) You need to be on the same node/server as your running program to debug it. By running interactively we can debug your program by running a debugger. This is mostly beyond the scope of the session and can be its own workshop. 
1. Demo `netstat` network diagnosis tool. 

1. Have the participants download the cryptic program `wget https://github.com/ualberta-rcg/public/raw/master/HPC-Tuning/cryptic` make it exacutable `chmod 700 ./cryptic ` run the program interactivly and figure out how much memory this program requires. 


