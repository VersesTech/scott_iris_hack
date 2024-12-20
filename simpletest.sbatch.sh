#!/bin/bash
#SBATCH -G 1
#SBATCH --gres=gpu:1
#SBATCH --job-name=simpletest_BreakoutNoFrameskip-v4_50epoch_sa50
#SBATCH --output=log.simpletest_BreakoutNoFrameskip-v4_50epoch_sa50_%j.out
#SBATCH --error=log.simpletest_BreakoutNoFrameskip-v4_50epoch_sa50_%j.err

# user / repo config
current_user="scott"
repo_name="scott_iris_hack_dec20"
env_name="iris_env_scott_cluster_loginnode_3_9_20"

# training config
game_name="BreakoutNoFrameskip-v4"
common_device="cpu"
wandb_mode="offline"
common_epochs=4
stop_after_epochs=1
max_snapshots=2
#RUN_DIR="./simpletest_outputs/iris/${game_name}-${common_epochs}epoch_sa${stop_after_epochs}/$(date +'%Y-%m-%d')/$(date +'%H-%M-%S')"
RUN_DIR="./simpletest_outputs/$(date +'%H-%M-%S')"
train_command="python src/main.py \
  env.train.id=\"$game_name\" \
  common.device=\"$common_device\" \
  wandb.mode=\"$wandb_mode\" \
  common.epochs=$common_epochs \
  collection.train.stop_after_epochs=$stop_after_epochs \
  collection.train.max_number_of_snapshots_saved=$max_snapshots \
  hydra.run.dir=\"$RUN_DIR\""

# run the training
echo "running training command: ${train_command}"
eval "${train_command}"