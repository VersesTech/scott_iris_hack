#!/bin/bash
# basic template for jobs; todo: create scripts for training sessions
#  1. train_pong-300-50.sbatch
#  2. train_pong-200-50.sbatch
#  3. train_pong-600-50.sbatch
#  4. train_pong-300-500.sbatch
#  5. train_pong-200-500.sbatch
#  6. train_pong-600-500.sbatch

#  7. train_breakout-300-50.sbatch
#  8. train_breakout-200-50.sbatch
#  9. train_breakout-600-50.sbatch
# 10. train_breakout-300-500.sbatch
# 11. train_breakout-200-500.sbatch
# 12. train_breakout-600-500.sbatch

# 13. train_boxing-300-50.sbatch
# 14. train_boxing-200-50.sbatch
# 15. train_boxing-600-50.sbatch
# 16. train_boxing-300-500.sbatch
# 17. train_boxing-200-500.sbatch
# 18. train_boxing-600-500.sbatch

#SBATCH -G 1
#SBATCH --gres=gpu:1
#SBATCH --job-name=PongNoFrameskip-v4_300_50
#SBATCH --output=log.PongNoFrameskip-v4_300_50_%j.out
#SBATCH --error=log.PongNoFrameskip-v4_300_50_%j.err

cd /home/scott/github/VersesTech/scott_iris_hack/
source iris_env_scott_cluster_loginnode_3_9_20/bin/activate

python src/main.py \
  env.train.id=PongNoFrameskip-v4 \
  common.device=cpu \
  wandb.mode=online \
  common.epochs=300 \
  collection.train.stop_after_epochs=50 \
  collection.train.max_number_of_snapshots_saved=150 \
  hydra.run.dir="/shared/scott/training_outputs/iris/PongNoFrameskip-v4/$(date +'%Y-%m-%d')/$(date +'%H-%M-%S')"