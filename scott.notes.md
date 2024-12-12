
# steps


## install dependencies


### set up python 3.9 venv, activate it

requires: python 3.9 and the changes I've made to the repo (requirements)
```
python3.9 -m venv iris_env
source iris_env/bin/activate
pip install --upgrade pip setuptools
pip install -r requirements.txt
```

### download roms

requires a directory called roms
`AutoROM --install-dir roms --accept-license`

### install roms

`ale-import-roms roms`



## train it

### using cuda (doesn't work on mac)
`python src/main.py env.train.id=BreakoutNoFrameskip-v4 common.device=cuda:0 wandb.mode=online`


### using cpu (works on mac)
note: this is slow, but it works. For m1/m2 we could use mps but 
`python src/main.py env.train.id=BreakoutNoFrameskip-v4 common.device=cpu wandb.mode=online`

### using mps (mac m series chips)

First, you need to the mps/metal version of pytorch:
`pip install torch==1.13.1 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/metal.html`

then, you can train:
`python src/main.py env.train.id=BreakoutNoFrameskip-v4 common.device=mps wandb.mode=online`

#### NOTE: this doesn't actually work for me
I get this error:
```
ce collection (train_dataset): 100%|███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 200/200 [00:06<00:00, 30.04it/s]

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

# notes
## python version

Seems like python version should be 3.9.
I started out with 3.11 and hit lots of issues, was not able to use the dependencies listed here.

Asked a couple llms to confirm my bias

### llm 0
After reviewing the project's requirements.txt and setup, I recommend using Python 3.8 or Python 3.9 for this project. Here's a comprehensive breakdown:

Key Dependencies:


PyTorch (deep learning framework)
NumPy
OpenAI's gym
Weights & Biases (wandb)
Hydra for configuration management


Specific Version Constraints:


The project likely requires Python 3.8-3.9 due to compatibility with:

PyTorch versions released during that period
Specific library version requirements
Deep learning framework compatibility




Why Not Python 3.11:
Python 3.11 might cause compatibility issues because:


Some deep learning libraries (like older PyTorch versions) may not have full support
Significant changes in Python 3.10+ can break backwards compatibility with certain scientific computing and machine learning libraries
Specific dependency versions might not be tested/validated against Python 3.11

### llm 1
To successfully install and run the IRIS project from the GitHub repository (https://github.com/eloialonso/iris), you should use Python 3.8 or 3.9. Here’s a detailed explanation of why these versions are recommended, including the chain of dependencies and why Python 3.11 may not work.
Recommended Python Versions
Compatibility with Dependencies:
The IRIS project specifies that it is developed with torch==1.11.0 and torchvision==0.12.0 as core dependencies. These versions of PyTorch and torchvision have been tested and confirmed to work well with Python 3.8 and 3.9.
You can verify this compatibility on the PyTorch previous versions page where it lists compatible Python versions for each release.
Installation Requirements:
The project’s requirements.txt file outlines all necessary dependencies, which include PyTorch, torchvision, and others that are compatible with Python 3.8 and 3.9.
Using these versions ensures that you avoid potential issues during installation or runtime due to incompatible library versions.
Chain of Dependencies
Primary Libraries:
PyTorch: The core library for deep learning tasks in this project.
torchvision: Provides utilities for image processing and datasets used in conjunction with PyTorch.
Other Dependencies: The project may also rely on additional libraries (e.g., NumPy, Gym) that might have their own compatibility constraints with different Python versions.
Why Python 3.11 May Not Work
Library Compatibility:
As of now, many libraries, including PyTorch (up to version 1.11.0), may not fully support Python 3.11 yet. This can lead to runtime errors or unexpected behavior when using features from these libraries.
For example, if you attempt to run the IRIS project with Python 3.11, you might encounter errors related to missing functions or classes that are not yet implemented or compatible with that version.
Testing and Stability:
The IRIS project has been tested against specific versions of its dependencies under Python 3.8 and 3.9, ensuring stability and reliability during execution.
Using a newer version like Python 3.11 introduces uncertainty regarding compatibility and may lead to untested scenarios resulting in crashes or bugs.
Conclusion
In summary, using Python 3.8 or 3.9 is recommended for installing and running the IRIS project due to:
Compatibility with core dependencies like PyTorch and torchvision.
Avoiding potential issues related to library support in newer Python versions.
Ensuring stability as the project has been tested under these environments.
By adhering to these guidelines, you can effectively set up the IRIS project without encountering compatibility issues that could arise from using unsupported Python versions like 3.11.
### llm 2
To run the IRIS project (Transformers as Sample-Efficient World Models) from its GitHub repository, it is recommended to use Python 3.9. This choice stems from compatibility with the project's primary dependencies:

PyTorch 1.11.0 and torchvision 0.12.0: These versions were explicitly used during the development of the project. While newer versions of PyTorch may support later Python versions like 3.11, the dependency specifications suggest sticking with Python 3.9 for stability and reproducibility.

Other dependencies listed in requirements.txt: Compatibility issues may arise with dependencies that are not yet fully supported on Python 3.11. For example, older or unmaintained libraries in the ecosystem could break on newer Python versions due to syntax or structural changes introduced in Python 3.10 and 3.11.

Why Python 3.11 May Not Work
Backward Compatibility: Python 3.11 introduced features and changes (e.g., enhanced error messages, structural pattern matching) that may not be supported by older dependencies required by the project.
Dependency Conflicts: Libraries such as gym (used for environment simulation) or others in requirements.txt might not yet officially support Python 3.11.
Using Python 3.9 aligns with the configuration in the repository's documentation and ensures that all dependencies work as intended without conflicts. For further details, refer to the repository's setup instructions and dependency list on GitHub here​
