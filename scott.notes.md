# overview

The original requirements.txt file won't build as-is (without indeterminate hacking).

Even downgrading to python 3.9 didn't do the trick. 

Regardless: our clusters run 3.11.5, so I've updated the requirements to work with that version.

I've tried to update only the packages that are necessary to get the code to run with 3.11.5.

Next step: pull down to the cluster and see if I can get our training of iris to work in a reproducible fashion.

# steps


## install dependencies


### set up python 3.11.5 venv, activate it

requires: python 3.11.5 and the changes I've made to the repo (requirements)
e.g.
```
brew install pyenv
pyenv install 3.11.5
```

```
~/.pyenv/versions/3.11.5/bin/python -m venv iris_env_3.11.5
source iris_env_3.11.5/bin/activate
pip install --upgrade pip setuptools
pip install -r requirements.txt
```

### download roms

requires a directory called roms
```
mkdir roms
AutoROM --install-dir roms --accept-license
```

### install roms

`ale-import-roms roms`



## train it
note you can use 'online' instead of 'disabled' for wandb.mode

### using cuda (doesn't work on mac)
`python src/main.py env.train.id=BreakoutNoFrameskip-v4 common.device=cuda:0 wandb.mode=disabled`


### using cpu (works on mac)
note: this is slow, but it works. For m1/m2 we could use mps but that doesn't seem to work well.
TODO check this again for python 3.11; this was true for 3.9...
`python src/main.py env.train.id=BreakoutNoFrameskip-v4 common.device=cpu wandb.mode=disabled`

### using mps (mac m series chips)

First, you need to the mps/metal version of pytorch:
`pip install torch==1.13.1 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/metal.html`

then, you can train:
`python src/main.py env.train.id=BreakoutNoFrameskip-v4 common.device=mps wandb.mode=disabled`

#### NOTE: this doesn't actually work for me
I get this error:
```
Epoch 5 / 600

Experience collection (train_dataset): 100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 200/200 [00:06<00:00, 33.11it/s]
Experience collection (test_dataset): 100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 16/16 [00:22<00:00,  1.40s/it]
Assertion failed: (0 <= mpsAxis && mpsAxis < 4 && "Runtime canonicalization must simplify reduct[1]    25954 abort      python src/main.py env.train.id=BreakoutNoFrameskip-v4 common.device=mps 
(iris_env) ➜  scott_iris_hack git:(main) /opt/homebrew/Cellar/python@3.9/3.9.20/Frameworks/Python.framework/Versions/3.9/lib/python3.9/multiprocessing/resource_tracker.py:216: UserWarning: resource_tracker: There appear to be 7 leaked semaphore objects to clean up at shutdown
  warnings.warn('resource_tracker: There appear to be %d '

```
you can get back to basic torch via
```
pip uninstall torch torchvision torchaudio
pip install -r requirements.txt
```
