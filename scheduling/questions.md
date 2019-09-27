# Questions 

1. Serial Job, basic
   - Submit a serial job that:
     * Is a serial (1 core) job 
     * Emails you when is starts, ends and aborts
     * Has a maximum wall time of 2 minutes
     * Runs the ‘hostname’ command
   - Make a note of the jobid when your job is submitted
   - Watch your job run with the following command:
     * `squeue -u $USER`
   - Did you get the result emailed to your accoun
   - Display the job output file.
   - Examine the emails you have received.  
     
       
2. Serial Job, output
   - Submit a serial job that: 
     * Is a serial (1 core) job 
     * Emails you when is starts, ends and aborts
     * Has a maximum wall time of 2 minutes
     * Writes the standard output and standard error into separate files.
     * Runs the ‘hostname’ command
     * **Sleeps for 30 seconds**
   - Writes the standard output and standard error into separate files.
   - Make a note of the jobid when your job is submitted
   - Watch your job run with the following command:
     * `squeue -u $USER`
     * `scontrol show job <jobid>`
   - Did you get the result emailed to your account
   - Display the job output file.
   - Examine the emails you have received.


3. Serial Job, error
   - Submit a serial job that:
     * Is a serial (1 core) job 
     * Emails you when is starts, ends and aborts
     * Has a maximum wall time of 2 minute
     * Runs the ‘hostname’ command
     * Writes the standard output and standard error into separate files.
     * **Runs the non existent command ‘hello’**
   - Make a note of the jobid when your job is submitted
   - Watch your job run with the following command: 
      * `squeue -u $USER`
      * `sscontrol show job <jobid>`
   - Did you get the result emailed to your account
   - Display the job output and error files. 
   - Examine the emails you have received.
 
4. Serial Job, Walltime
    - Submit a serial job that:
      * Is a serial (1 core) job 
      * Emails you when is starts, ends and aborts
      * **Has a maximum wall time of 2 minutes**
      * Runs the ‘hostname’ command
      * Writes the standard output and standard error into separate files.
      * **Sleeps for 200 seconds**
   - Think about what will you think happen when this jobs runs?
   - Make a note of the jobid when your job is submitted 
   - Watch your job run with the following commands:
      * `squeue -u $USER`
      * `scontrol show job <jobid>`
   - Examine the job output and error files.
   - Examine the emails you have recieved
   - Display the job output and error files. 
   
5. Serial Job, Job names
   - Submit a serial job that:
     * Is a serial (1 core) job 
     * Emails you when is starts, ends and aborts
     * Has a maximum wall time of 2 minutes
     * Runs the ‘hostname’ command
     * Writes the standard output and standard error into separate files.
     * **Sleeps for 30 seconds** 
     * **Has a name you selected**
   - Look at your job in the output of the following commands
     * `squeue -u $USER`
     * `scontrol show job <jobid>`
   - Examine the job output file(s).
   - Examine the emails you have recieved
   - Display the job output and error files. 
  
6. Interactive, serial Job
   - Open a second ssh session/terminal to the workshop cluster
   - In the second ssh session submit a job that: 
     * Is a serial (1 core) job
     * Has a maximum wall time of 20 minutes
     * Emails you when the job is aborted, before it runs and a after it ends
     * Is named “my-first-interactive-job”
     * Is interactive
   - Wait for the job to be allocated after it is allocated answer the following questions
     * Look at the command line you are on. 
     * Which node are you on?
       * *Hint:* `hostname`
     * Print and look at all the slurm variables
       * *Hint:* `printenv | grep SLURM`
     * Find out on which node is your job allocated
       * *Hint:* `echo $SLURM_NODELIST`
       * *Hint:* `hostname`      
     * What is the jobs name?
       * *Hint:* `echo $SLURM_JOB_NAME`
     * In which directory are you? 
       * *Hint:* `pwd`
     * Which directory has the job been submitted from?
       * *Hint:* `echo $SLURM_SUBMIT_DIR`
     * What is the path to executable for this job?
       * *Hint:* `echo $PATH`
   - The current interactive job only uses 1 process, on 1 core, inside 1 task, inside 1 step, and does not use arrays but for future comparison with other more complex job types run the following commands and write down the results 
     * Give a list of node names where each process (there is only one in this case) of this job runs? 
       * *Hint:* `echo $SLURM_JOB_NODELIST`
     * On how many nodes (there is only one in this case) does this job run?
       * *Hint:* `echo $SLURM_JOB_NUM_NODES`
       * *Hint:* `echo $SLURM_NNODES`
     * What is the total number of tasks in this allocation
       * *Hint:* `echo $SLURM_NTASKS`
     * What is the number of tasks per node (listed by node)
       * *Hint:* `echo $SLURM_TASKS_PER_NODE`
     * How many steps are in this job
       * *Hint:* `echo $SLURM_ SLURM_STEPID`
     * What is the array ID of this job? 
       * *Hint:* `echo $SLURM_ARRAY_TASK_ID`
       * *Hint:* in this case there is none.
   - **Optional for advanced Unix users:** 
     * List the jobs cpuset/cgroup. A cpuset or cgroup is used to assigning a set of processor and memory to a set of hardware resources, and can be used by the scheduling system to keep a job from using resources assigned to other jobs.
       * *Hint:* `ls /sys/fs/cgroup/cpuset/slurm/uid_$SLURM_JOB_UID/job_$SLURM_JOB_ID/step_$SLURM_STEPID`
     * Show which cores and which memory set that your job is running on?
       * *HINT:* `cat /sys/fs/cgroup/cpuset/slurm/uid_$SLURM_JOB_UID/job_$SLURM_JOB_ID/step_$SLURM_STEPID/cpuset.cpus`
       * *HINT:* `cat /sys/fs/cgroup/cpuset/slurm/uid_$SLURM_JOB_UID/job_$SLURM_JOB_ID/step_$SLURM_STEPID/ cpuset.mems`
    - Close the interactive shell by running the exit command or typing ^D (control d)

      
7. Job arrays
   - Submit a serial **job array** that: 
     * Has a maximum wall time of 2 minutes
     * Sleeps 30 seconds
     * Runs the command “hostname”
     * Is named “my-array-job”
     * **Has 12 tasks**
     * **Writes a output file to: q7-\<jobid>-\<arrayid>.out**
     * **Writes a error file to: q7-\<jobid>-\<arrayid>.err**
   - Run the following commands to see your job running 
     * `squeue –u $USER`
     * `scontrol show job <jobid>`
   - Look at the job output files

8. Job Arrays, limit number runing tasks
   - Submit a serial job array that: 
     * Has a maximum wall time of 2 minutes
     * Sleeps 30 seconds
     * Runs the command “hostname”
     * Is named “my-array-job2”
     * Has 12 tasks**
     * Writes a output file to: q8-\<arrayid>.out
     * Writes a error file to: q8-\<arrayid>.err
     * **Runs at most 2 jobs at once** 
   - Run the following commands to see your job running 
     * `squeue –u $USER`
     * `scontrol show job <jobid>`
   - Look at the job output files

9. Job arrays, indexes
   - Submit a serial job array that: 
     * Has a maximum wall time of 2 minutes
     * Sleeps 30 seconds
     * Runs the command “hostname”
     * Is named “my-array-job3”
     * Has 4 tasks with indexes of: 1, 2, 7, 13
     * Writes a output file to: q9-\<arrayid>.out
     * Writes a error file to: q9-\<arrayid>.err
     * **Runs at most 2 jobs at once** 
   - Run the following commands to see your job running 
     * `squeue –u $USER`
     * `scontrol show job <jobid>`
   - Look at the job output files

10. Job arrays, 
   - Submit a job that: 
     * Has 2 tasks with indexes of: 1, 4
     * Asks for 1 core per task
     * Has a maximum wall time of 2 minutes
     * Emails you when the job is aborted, before it runs and a after it ends
     * Is named “my-array-var-job”
   - Look at the SLURM environment variables:
     * Give a list of node names where each process of this job runs? 
       * *Hint:* `echo $SLURM_JOB_NODELIST`
     * On how many nodes does this job run
       * *Hint:* `echo $SLURM_JOB_NUM_NODES`
       * *Hint:* `echo $SLURM_NNODES`
     * What is the total number of tasks in this allocation?
       * *Hint:* `echo $SLURM_NTASKS`
     * What is the number of tasks per node (listed by node)?
       * *Hint:* `$SLURM_TASKS_PER_NODE`  
     * How many steps are in this job?
       * *Hint:* `echo $SLURM_STEP_NUM_TASKS`
     * What is the task id in the array of this job?
       * *Hint:* `echo $SLURM_ARRAY_TASK_ID`
     * Prints all the SLURM variables
       * *Hint:* `printenv | grep SLURM`

11. Array job with inputs example  **Advanced** 
   - Submit a serial job array that: 
     * Is named “my-input-array-job”
     * Has 4 tasks with 1 procs each
     * Emails you when your job is complete.
     * The file that is used as input is named: “input.array”
   - Have each job array output double the first number and adding the second.
   - Run the job and see the output
   - As advanced work if time permits see if you can output in a single file as opposed to many array files.
              
12. MPI Jobs
   - Submit the start-mpi.sh  job 
   - Look at the job with the following commands:
     * `squeue –u $USER`
     * `scontrol show job <jobid>`
     * `scontrol show jobid -dd <jobid>`
   - Note how long it took to run
   - Edit the start-mpi.sh  script to user 4 processors
   - Submit the edited script
   - Look at the job with the following commands:
     * `squeue –u $USER`
     * `scontrol show job <jobid>`
     * `scontrol show jobid -dd <jobid>`
   - Please list which nodes and cores the job is running on or scheduled to run on and how long it took to run.
   - Compaer the runtime of the codes.

13. MPI, Interactive Job
   - Submit a job that:
     * Asks 4 cores
     * Has a walltime of 20 minutes 
     * is interactive
   - After the job starts look at the SLURM environment variables
     * *Hint:* `printenv | grep -i slurm`
     * What is the jobs id? 
       * *Hint:* `echo $SLURM_JOB_ID`
     * On how many nodes does this job run? 
       * *Hint:* `echo $SLURM_NNODE`
     * With how many processes does this job run?    
       * *Hint:* `echo $SLURM_NPROCS`
     * On which node(s) is your job allocated?
       * *Hint:* `echo $SLURM_JOB_NODELIST` 
     * On how many processors per node is the job allocated  
       * *Hint:* `echo $SLURM_JOB_CPUS_PER_NODE`
     * On how many tasks per node is the job allocated? 
       * *Hint:* `echo $SLURM_TASKS_PER_NODE`
     * Run the command `srun hostname ` 
    

14. MPI, Interactive Job
   - Submit a job that:
     * **Asks 4 cores on a single node**
     * Has a walltime of 20 minutes 
     * is interactive
   - After the job starts look at the SLURM environment variables
     * *Hint:* `printenv | grep -i slurm`
     * What is the jobs id? 
       * *Hint:* `echo $SLURM_JOB_ID`
     * On how many nodes does this job run? 
       * *Hint:* `echo $SLURM_NNODE`
     * With how many processes does this job run?     
       * *Hint:* `echo $SLURM_NPROCS`
     * On which node(s) is your job allocated?
       * *Hint:* `echo $SLURM_JOB_NODELIST` 
     * On how many processors per node is the job allocated  
       * *Hint:* `echo $SLURM_JOB_CPUS_PER_NODE`
     * On how many tasks per node is the job allocated? 
       * *Hint:* `echo $SLURM_TASKS_PER_NODE`
    
15. OpenMP jobs 
   - Submit a job 
     * Asking for 1 node with 4 cores
     * Has a maximum walltime of 20 minutes 
     * Is interactive
   - After the job starts look at the SLURM environment variables
     * *Hint:* `printenv | grep -i slurm`
     * What is the jobs id? 
       * *Hint:* `echo $SLURM_JOB_ID`
     * On how many nodes does this job run? 
       * *Hint:* `echo $SLURM_NNODE`
     * With how many processes does this job run?     
       * *Hint:* `echo $SLURM_NPROCS`
     * On which node(s) is your job allocated?
       * *Hint:* `echo $SLURM_JOB_NODELIST` 
     * On how many processors per node is the job allocated  
       * *Hint:* `echo $SLURM_JOB_CPUS_PER_NODE`
     * On how many tasks per node is the job allocated? 
       * *Hint:* `echo $SLURM_TASKS_PER_NODE`
     * How many cores per task are alloacted for this job
       * *Hint:* `$SLURM_CPUS_PER_TASK"`

16. Hybrid jobs 
   - Submit a job 
     * Asking for 3 node with 2 tasks each and 2 cores per task
     * Has a maximum walltime of 20 minutes 
     * Is interactive
   - After the job starts look at the SLURM environment variables
     * *Hint:* `printenv | grep -i slurm`
     * What is the jobs id? 
       * *Hint:* `echo $SLURM_JOB_ID`
     * On how many nodes does this job run? 
       * *Hint:* `echo $SLURM_NNODE`
     * With how many processes does this job run?     
       * *Hint:* `echo $SLURM_NPROCS`
     * On which node(s) is your job allocated?
       * *Hint:* `echo $SLURM_JOB_NODELIST` 
     * On how many processors per node is the job allocated  
       * *Hint:* `echo $SLURM_JOB_CPUS_PER_NODE`
     * On how many tasks per node is the job allocated? 
       * *Hint:* `echo $SLURM_TASKS_PER_NODE`
     * How many cores per task are alloacted for this job
       * *Hint:* `$SLURM_CPUS_PER_TASK"`
       
17. Jobs and memory 
   - Take the start-mem.pbs  script and edit it so that is asks for: `--mem-per-cpu=1000`
   - Submit a job  from the script you edited . Look at the job with the following commands
     * `squeue –u $USER`
     * `scontrol show job -dd <jobid>`
   - How much memory does this job use.
   
18. Jobs and memory 
   - Take the start-mem.pbs  script and edit it so that is asks for: `--mem=1000`
   - Submit a job  from the script you edited . Look at the job with the following commands
     * `squeue –u $USER`
     * `scontrol show job -dd <jobid>`
   - How much memory does this job use.   

19. Jobs and memory 
   - Take the start-mem.pbs  script and edit it so that is asks for: `--mem-per-cpu=250`
   - Submit a job  from the script you edited . Look at the job with the following commands
     * `squeue –u $USER`
     * `scontrol show job -dd <jobid>`
   - How much memory does this job use.  

20. Jobs and memory  (appropriate resources)
   - Create a job run the “cryptic” program edit the start-mem2.sh
   - Make sure your job emails you when is starts, ends and aborts
   - Make a guess and for enough RAM to run the program 
   - Submit your edited Job script , look at your running Job with the following commands, look at the ,memory used by your job
     * `squeue –u $USER`
     * `scontrol show job -dd <jobid>`
   - Did your job run successfully? Or fail because of a lack of memory? 
   - If your job failed due to a lack of memory, increase the maximum memory requested and resubmit your job
   - Look at the email reporting on your job success, how much resources were reported used. Compare the memory used to the reported memory in point 
   - while the job is running attach to the job with teh following command 
     * `srun --jobid <jobid> --pty  bash`
     * then run top and see how much resources cryptic is useing. 
     * exit with the exit command 
   - Once you know the apropreate memory needed edit job script and request an appropriate amount of memory to run the Job .
   - Submit your new job
   - Verify that the jobs runs successfully.
   
21. GPUs 
   - Submit a job asking for:
     * 1 gpu
     * 1 cpu
     * Has a maximum wall time of 10 minutes
     * Sleeps 500 seconds
   - Runs the command scontrol showjob
   
22.	Software licenses and generic resources 
   - Currently not implemented on cluster

23. Submit a job asking for that asks for:
   - 2 tasks
   - 1 node
   - Not to run on any nodes with other jobs (Useful if you are trying to debug your job)
   - See if you can see which nodes your job is running on.
     * `scontrol show job <jobid>`

24. Job dependencies 
   - Submit a serial job named dep1, that has:
     * Walltime of 2:00 
     * Sleeps 120 seconds
     * Submit a serial job 22b waits until job dep2 is done
     * Walltime of 2:00 
     * Sleeps 120 seconds
   - Look at job dep2 with “scontrol show job <jobid>”
   - Run the command 
     * `squeue -u $USER` 
   - Verify that Job dep1 complete before dep2 starts

25. Job using temporary directory 
   - Submit a job that runs in the temporary directory used no more than 1GB of space.

26. Job environment variables. 
   - Submit a serial job that prints the partition(s) that the job was ran in
 
27. Multiple accounting groups
   - Submit a Job:
     * to a non default accounting group
     * that asks for 1 proc
   - Try to see which accounting group your job belongs to, use the scontrol command: 
     * `scontrol show job <jobid>`

28. Basic Job info   
   - Use the following commands to find out how many of your jobs are running, queued, in hold state or complete.
     * `squeue -u $USER`
     * `scontrol show jobid -dd <jobid>`
   - Use the follwing commands to find out how many jobs are running, queued, in hold state or complete on the cluster.
     * `squeue`
 
29. Examining a job 
   - Start a Job  
   - Examine its priority with ”sprio”
   - run `scontrol show jobid -dd <jobid>` and determine how much RAM the Job asks for/used
 
30. Job holds
   - See if any of your jobs in the queue have any job holds, if so identify the hold and the reason why.
 
31. How many idle nodes are on the cluster 
   - `sinfo  --states=idle1
   - How many nodes are down and drained 
     * `sinfo –R`
