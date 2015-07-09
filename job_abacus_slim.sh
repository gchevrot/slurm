#! /bin/bash
#SBATCH -J CHOL_TO    
#SBATCH --account sdumembio_slim
#SBATCH --nodes 32
# MPI ranks per node:
#SBATCH --ntasks-per-node 24
## Next line is walltime = 1 days - 0 hours == Max
#SBATCH --time 24:00:00
#SBATCH --mail-type=ALL
#SBATCH --output out.txt
#SBATCH --error  err.txt
echo Running on $(hostname)
echo Available nodes: $SLURM_NODELIST
echo Slurm_submit_dir: $SLURM_SUBMIT_DIR
echo Start time: $(date)
cd $SLURM_SUBMIT_DIR # not necessary, is done by default
#load relevant module
module purge
module add gromacs/5.0.5  

if [ "${CUDA_VISIBLE_DEVICES:-NoDevFiles}" != NoDevFiles ]; then
    cmd="mdrun_gpu_mpi"
else
    cmd="mdrun_mpi"
fi

# Cores per MPI rank
OMP=$(( 24 / $SLURM_NTASKS_PER_NODE ))

srun $cmd -pin on -ntomp $OMP -notunepme -deffnm run -cpi run.cpt -append -v 

