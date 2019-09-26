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
     * ***Sleeps for 30 seconds***
   - Writes the standard output and standard error into separate files.
   - Make a note of the jobid when your job is submitted
   - Watch your job run with the following command:
     * squeue -u $USER
     * scontrol show job <jobid>
   - Did you get the result emailed to your account
   - Display the job output file.
   - Examine the emails you have received.


