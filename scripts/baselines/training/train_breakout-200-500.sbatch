#!/bin/bash
#SBATCH -G 1
#SBATCH --gres=gpu:1
#SBATCH --job-name=CHANGEME__BreakoutNoFrameskip-v4__200__500
#SBATCH --output=log.CHANGEME__BreakoutNoFrameskip-v4__200__500_%j.out
#SBATCH --error=log.CHANGEME__BreakoutNoFrameskip-v4__200__500_%j.err

cd /home/scott/github/VersesTech/scott_iris_hack/
source iris_env_scott_cluster_loginnode_3_9_20/bin/activate

python src/main.py \
  env.train.id=BreakoutNoFrameskip-v4 \
  common.device=cuda:0 \
  wandb.mode=online \
  common.epochs=200 \
  collection.train.stop_after_epochs=500 \
  collection.train.max_number_of_snapshots_saved=0 \
  hydra.run.dir="/shared/scott/training_outputs/iris/BreakoutNoFrameskip-v4/$(date +'%Y-%m-%d')/$(date +'%H-%M-%S')"