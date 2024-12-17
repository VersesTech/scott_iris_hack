python src/main.py env.train.id=PongNoFrameskip-v4 common.device=cpu wandb.mode=offline common.epochs=1 collection.train.stop_after_epochs=1 collection.train.config.num_steps=10 collection.train.max_number_of_snapshots_saved=10 initialization.output_path=/shared/scott/blah

