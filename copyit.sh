rsync -avz --progress -e ssh --exclude='outputs' --exclude='iris_env_scott_local_3_9_20' --exclude='iris_env_scott_cluster_loginnode_3_9_20' /Users/scottcarroll/github/VersesTech/scott_iris_hack/scripts/baselines/training/*Freeway* scott@ec2-34-207-230-166.compute-1.amazonaws.com:/home/scott/github/VersesTech/scott_iris_hack/scripts/baselines/training/

