#! /bin/bash

##############################################################################################
# Automatically submit $sh_name:                                                             #
# This script tests every $dt if $job_name is in queue. If it is in queue, it does nothing.  #
# If it is not in queue, $sh_name is resubmitted.                                            #
# Be careful that your job_name is unique and do not exceed 8 characters!!!                  #
# Usage:                                                                                     #
# >nohup ./job_submission.sh X_times script.sh squeue_name > job.log &                                                       #
##############################################################################################

# Change these values if necessary:
dt=1800				            # Every $dt [in seconds], the script check if the job is in queue or not
name=chevrot 

# This script need 3 arguments
if [ $# -ne 3 ] ; then
    echo "This command needs 3 arguments: 
          -1- Number of times the job will be re-submit. 
          -2- Name of the script that will be submitted with sbatch (SLURM).
          -3- Name of the job as it is named in the SLURM script (line SBATCH -J). This name should be UNIQUE and have less than 8 characters.
          
          Example:
          nohup ./job_submission.sh 10 job.sh POPE > job.log &
          The script job.sh with the \"squeue name\" POPE will be automatically submitted 10 times
          "

else
    n_times=$1  		        # Number of times the job will be re-submit. This is a security - so you won't be stuck in an infinite loop
    sh_name=$2               	# Name of the script that will submit with sbatch (SLURM)
    job_name=$3  		        # Should be unique and not exceed 8 characters!

    # Testing that job_name do not exceed 8 characters:
    maxlen=8
    if (( ${#job_name} > $maxlen )); then
        echo "You are using ${#job_name} characters for the SLURM name. The SLURM name should not exceed $maxlen characters."
        exit 1
    fi

    # Loop to automatically re-submit your job
    while [ "$n_times" != 0 ]; do
        if [[ `squeue -u $name | grep $job_name` ]]; then
            echo "sleep $dt seconds"
            sleep $dt
        else
            echo "$n_times"
    	n_times=$(( $n_times - 1))
    	sbatch $sh_name
    	sleep 10
        fi
    done

fi
