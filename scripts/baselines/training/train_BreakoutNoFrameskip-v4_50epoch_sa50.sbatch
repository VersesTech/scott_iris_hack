#!/bin/bash
#SBATCH -G 1
#SBATCH --gres=gpu:1
#SBATCH --job-name=BreakoutNoFrameskip-v4_50epoch_sa50
#SBATCH --output=log.BreakoutNoFrameskip-v4_50epoch_sa50_%j.out
#SBATCH --error=log.BreakoutNoFrameskip-v4_50epoch_sa50_%j.err

# user / repo config
current_user="scott"
repo_name="scott_iris_hack"
env_name="iris_env_scott_cluster_loginnode_3_9_20"

# training config
game_name="BreakoutNoFrameskip-v4"
common_device="cuda:0"
wandb_mode="online"
common_epochs=50
stop_after_epochs=50
max_snapshots=150
RUN_DIR="/shared/${current_user}/training_outputs/iris/${game_name}-${common_epochs}epoch_sa${stop_after_epochs}/$(date +'%Y-%m-%d')/$(date +'%H-%M-%S')"
train_command="python src/main.py \
  env.train.id=\"$game_name\" \
  common.device=\"$common_device\" \
  wandb.mode=\"$wandb_mode\" \
  common.epochs=$common_epochs \
  collection.train.stop_after_epochs=$stop_after_epochs \
  collection.train.max_number_of_snapshots_saved=$max_snapshots \
  hydra.run.dir=\"$RUN_DIR\""

# go to repo, activate env
cd "/home/${current_user}/github/VersesTech/${repo_name}/"
source "${env_name}/bin/activate"

# clone current repo to the training output directory for posterity
echo "cloning current repo to ${RUN_DIR}"
git clone --no-hardlinks . "${RUN_DIR}/git_repo"
echo "zipping up git repo"
zip -r "${RUN_DIR}/git_repo.zip" "${RUN_DIR}/git_repo" && rm -rf "${RUN_DIR}/git_repo"

# run the training
echo "running training command: ${train_command}"
eval "${train_command}"