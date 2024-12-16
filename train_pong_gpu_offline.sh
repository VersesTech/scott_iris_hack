cd /home/scott/github/VersesTech/scott_iris_hack/
source iris_env_scott_cluster_loginnode_3_9_20/bin/activate
python src/main.py env.train.id=PongNoFrameskip-v4 common.device=cuda:0 wandb.mode=offline

