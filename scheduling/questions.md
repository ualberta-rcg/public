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
     * **Writes a output file to: q7-<jobid>-<arrayid>.out**
     * **Writes a error file to: q7-<jobid>-<arrayid>.err**
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
     * Writes a output file to: q8-<arrayid>.out
     * Writes a error file to: q8-<arrayid>.err
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
     * Writes a output file to: q9-<arrayid>.out
     * Writes a error file to: q9-<arrayid>.err
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
       
       
