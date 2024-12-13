
## check out envs in gym
import gymnasium as gym
#for python 3.11
#print(*sorted(gym.envs.registry.keys()), sep="\n")
import ale_py
gym.register_envs(ale_py)
env = gym.make("ALE/Breakout-v5")

## this is for python 3.9
#env_ids = [env_spec.id for env_spec in gym.envs.registry.all()]
#print(*sorted(env_ids), sep="\n")

## check torch version
#import torch
#print(f"torch version: {torch.__version__}")

## check torchvision version
#import torchvision
#print(f"torchvision version: {torchvision.__version__}")


## check if pytorch is built with MPS support
#import torch
#print(torch.__version__)
#print(torch.backends.mps.is_available())  # Check if MPS is available