#!/bin/bash
#SBATCH -G 1
#SBATCH --job-name=off_pong_100k  # Name of the job
#SBATCH --gres=gpu:1                       # Request 1 GPU
#SBATCH --output=log.off_pong_100k_%j.out     # Log standard output to a file (job ID will replace %j)
#SBATCH --error=log.off_pong_100k_%j.err      # Log standard error to a file (job ID will replace %j)


# Execute the main script
bash /home/scott/github/VersesTech/scott_iris_hack_2/train_pong_gpu_offline.sh
