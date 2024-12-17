#!/bin/bash
#SBATCH -G 1
#SBATCH --gres=gpu:1
#SBATCH --job-name=PongNoFrameskip-v4_200_50
#SBATCH --output=log.PongNoFrameskip-v4_200_50_%j.out
#SBATCH --error=log.PongNoFrameskip-v4_200_50_%j.err

cd /home/scott/github/VersesTech/scott_iris_hack/
source iris_env_scott_cluster_loginnode_3_9_20/bin/activate

python src/main.py \
  env.train.id=PongNoFrameskip-v4 \
  common.device=cpu \
  wandb.mode=online \
  common.epochs=200 \
  collection.train.stop_after_epochs=50 \
  collection.train.max_number_of_snapshots_saved=150 \
  hydra.run.dir="/shared/scott/training_outputs/iris/PongNoFrameskip-v4/$(date +'%Y-%m-%d')/$(date +'%H-%M-%S')"