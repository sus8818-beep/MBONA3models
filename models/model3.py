# model3.py by K.Yamauchi
# Please make sure that class model3 extends class model2. 
# Although this source code does not include learning(), model3.learning() is the same as model2.learning().
# Out() is overrided.
# getWinnerKernel() is newly introduced.

from .model2 import model2
from sharedModel.kernel import kernel
import numpy as np
from numpy.typing import NDArray

class model3(model2):
    def __init__(self, gamma, budget, phi, spontaneousPhi):
        super(model3, self).__init__(gamma, budget, phi)
        self.spontaneousPhi = spontaneousPhi

    def learning(self, x, y):
        if self.ClassificationErr(x,y) > 0:
            ## recover the winner kernel's sigma
            if len(self.kernels) > 0:
                winnerKernel = self.getWinnerKernel()
                winnerKernel.resetSigma()
                self.Shrink(self.spontaneousPhi)
        else:
            self.kernels.append(kernel(x, y, self.gamma))
            self.Shrink(self.phi)
            if len(self.kernels) > self.budget:
                targetKernel = self.getOldestKernel()
                self.kernels.remove(targetKernel)

    def getWinnerKernel(self) -> kernel:
        winnerObj = max(self.kernels, key=lambda k: k.currentExpout)
        return winnerObj
