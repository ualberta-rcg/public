# Questions and Answers

## General

### Questions

1. Serial Job, basic
   - Submit a serial job that:
     * Is a serial (1 core) job 
     * Emails you when is starts, ends and aborts
     * Has a maximum wall time of 2 minutes
     * Runs the ‘hostname’ command
   - Make a note of the jobid when your job is submitted
   - Watch your job run with the following command:
     * squeue -u $USER
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
     * squeue -u $USER
     * scontrol show job <jobid>
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
     * “squeue -u $USER”
     * “sscontrol show job <jobid>””
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
      * “squeue -u $USER”
      * “scontrol show job <jobid>”
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
     * squeue -u $USER
     * scontrol show job <jobid>
   - Examine the job output file(s).
   - Examine the emails you have recieved
   - Display the job output and error files. 
  
6. Interactive serial Job
   - Open a second ssh session/terminal to the workshop cluster
   - In the second ssh session submit a job that: 
     * Is a serial (1 core) job
     * Has a maximum wall time of 20 minutes
     * Emails you when the job is aborted, before it runs and a after it ends
     * Is named “my-first-interactive-job”
     * Is interactive
   - Wait for the job to be allocated after it is allocated answer the following questions
     * Look at the command line you are on. 
     * Which node are you on? *hostname*
     * Print and look at all the slurm variables. `printenv | grep SLURM`

