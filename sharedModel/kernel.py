import numpy as np
import linealg
from numpy.typing import NDArray

class kernel:
    def __init__(self, centroid, y, gamma):
        self.centroid = np.array(centroid)
        self.Y = np.array(y)
        self.gamma = gamma
        self.currentExpout = 0.0
        self.sigma = 1.0

    def Out(self, x) -> NDArray[np.float64]:
        X=np.array(x)
        diff = np.linalg.norm(X-self.centroid)
        diff = diff * diff
        self.currentExpout = math.exp(-diff * self.gamma)
        return self.currentExpout * self.Y * self.sigma

    def decaySigma(self, decayRate):
        self.sigma *= decayRate

    def getSigma(self) -> float:
        return self.sigma

    def getLastExpout(self) -> float:
        return self.currentExpout
