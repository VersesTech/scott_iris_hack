from typing import Any, Tuple

import numpy as np

from .done_tracker import DoneTrackerEnv


class SingleProcessEnv(DoneTrackerEnv):
    def __init__(self, env_fn):
        super().__init__(num_envs=1)
        self.env = env_fn()
        self.num_actions = self.env.action_space.n

    def should_reset(self) -> bool:
        return self.num_envs_done == 1

    def reset(self) -> np.ndarray:
        self.reset_done_tracker()
        obs = self.env.reset()
        return obs[None, ...]

    def step(self, action) -> Tuple[np.ndarray, np.ndarray, np.ndarray, np.ndarray, Any]:
        obs, reward, terminated, truncated, _ = self.env.step(action[0])  # action is supposed to be ndarray (1,)
        terminated = np.array([terminated])
        truncated = np.array([truncated])
        done = np.array([truncated or terminated])
        self.update_done_tracker(done)
        return obs[None, ...], np.array([reward]), terminated, truncated, None

    def render(self) -> None:
        self.env.render()

    def close(self) -> None:
        self.env.close()
