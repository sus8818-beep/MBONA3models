import math
import numpy as np
from numpy.typing import NDArray

class kernel:
    def __init__(self, centroid, y, gamma):
        self.centroid = np.array(centroid)
        self.Y = np.array(y)
        self.__gamma = gamma
        self.currentExpout = 0.0
        self.sigma = 1.0
        self.DEBUG = False

    def Out(self, x) -> NDArray[np.float64]:
        X = np.array(x)
        diff = np.linalg.norm(X - self.centroid)
        diff = diff * diff
        self.currentExpout = math.exp(-diff * self.__gamma)
        z = (self.currentExpout * self.sigma) * self.Y
        if self.DEBUG:
            print(f"kernel.Out() diff: {diff}, exp(-diff*gamma): {self.currentExpout}, self.Y: {self.Y}, sigma: {self.sigma}, output: {z}")
        return z

    def decaySigma(self, decayRate):
        self.sigma *= decayRate

    def resetSigma(self):
        self.sigma = 1.
