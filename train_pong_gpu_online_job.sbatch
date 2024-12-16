#!/bin/bash
#SBATCH --job-name=pong_100k  # Name of the job
#SBATCH --gres=gpu:1                       # Request 1 GPU
#SBATCH --output=log.train_pong_gpu_online_%j.out     # Log standard output to a file (job ID will replace %j)
#SBATCH --error=log.train_pong_gpu_online_%j.err      # Log standard error to a file (job ID will replace %j)


# Execute the main script
bash /home/scott/github/VersesTech/scott_iris_hack_2/train_pong_gpu_online.sh