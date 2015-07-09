Running jobs using Slurm
========================

Submit your batch job (*job_abacus_slim.sh* or *job_abacus_gpu.sh*) on a cluster
using [Slurm](http://slurm.schedmd.com/).

Use the script *job_submission.sh* to automatically submit your job.

Example::

    nohup ./job_submission.sh 10 job_abacus_slim.sh POPC_TO > job.log &

*job_abacus_slim.sh* will be submitted 10 times. `POPE` corresponds to the name
you use in *job_abacus_slim.sh* on line `#SBATCH -j`. This name should be
unique (don't use this name for other jobs) and contains less than 8
characters.





