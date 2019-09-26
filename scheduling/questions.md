# Questions 

## Serial Jobs 

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
     
       
1. Serial Job, output
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


1. Serial Job, error
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
 
1. Serial Job, Walltime
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
