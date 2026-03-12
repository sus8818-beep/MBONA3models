import math
import numpy as np
import linealg
from numpy.typing import NDArray

class kernel:
    def __init__(self, centroid, y, gamma):
        self.centroid = np.array(centroid)
        self.Y = np.array(y)
        self.__gamma = gamma
        self.__currentExpout = 0.0
        self.__sigma = 1.0

    def Out(self, x) -> NDArray[np.float64]:
        X=np.array(x)
        diff = np.linalg.norm(X-self.centroid)
        diff = diff * diff
        self.currentExpout = math.exp(-diff * self.__gamma)
        return self.__currentExpout * self.Y * self.__sigma

    def decaySigma(self, decayRate):
        self.__sigma *= decayRate

    def resetSigma(self):
        self.__sigma = 1.

    def getSigma(self) -> float:
        return self.__sigma

    def getLastExpout(self) -> float:
        return self.__currentExpout
