#!/bin/bash
#SBATCH -G 1
#SBATCH --gres=gpu:1
#SBATCH --job-name=BoxingNoFrameskip-v4_200_50
#SBATCH --output=log.BoxingNoFrameskip-v4_200_50_%j.out
#SBATCH --error=log.BoxingNoFrameskip-v4_200_50_%j.err


# user / repo config
current_user=$USER
repo_name="scott_iris_hack"
env_name="iris_env_scott_cluster_loginnode_3_9_20"

# training config
game_name="BoxingNoFrameskip-v4"
common_device="cuda:0"
wandb_mode="online"
common_epochs=200
stop_after_epochs=50
max_snapshots=150
RUN_DIR="/shared/${current_user}/training_outputs/iris/${game_name}/$(date +'%Y-%m-%d')/$(date +'%H-%M-%S')"

# go to repo, activate env
cd "/home/${current_user}/github/VersesTech/${repo_name}/"
source "${env_name}/bin/activate"


# clone current repo to the training output directory for posterity
git clone --no-hardlinks . "${RUN_DIR}/git_repo"

echo "python src/main.py \
  env.train.id=\"$game_name\" \
  common.device=\"$common_device\" \
  wandb.mode=\"$wandb_mode\" \
  common.epochs=$common_epochs \
  collection.train.stop_after_epochs=$stop_after_epochs \
  collection.train.max_number_of_snapshots_saved=$max_snapshots \
  hydra.run.dir=\"$RUN_DIR\""

exit 0

# run the training
python src/main.py \
  env.train.id="$game_name" \
  common.device="$common_device" \
  wandb.mode="$wandb_mode" \
  common.epochs=$common_epochs \
  collection.train.stop_after_epochs=$stop_after_epochs \
  collection.train.max_number_of_snapshots_saved=$max_snapshots \
  hydra.run.dir="$RUN_DIR"