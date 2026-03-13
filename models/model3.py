from .model2 import model2
from sharedModel.kernel import kernel
import numpy as np
from numpy.typing import NDArray

class model3(model2):
    def __init__(self, gamma, budget, phi, spontaneousPhi):
        super(model3, self).__init__(gamma, budget, phi)
        self.spontaneousPhi = spontaneousPhi

    def Out(self, x) -> NDArray[np.float64]:
        out = None
        for i in range(len(self.kernels)):
            if i==0:
                out = self.kernels[i].Out(x)
            else:
                out += self.kernels[i].Out(x)
        ## recover the winner kernel's sigma
        if len(self.kernels) > 0:
            winnerKernel = self.getWinnerKernel()
            winnerKernel.resetSigma()
            self.Shrink(self.spontaneousPhi)
        return out

    def getWinnerKernel(self) -> kernel:
        winnerObj = max(self.kernels, key=lambda k: k.currentExpout)
        return winnerObj
