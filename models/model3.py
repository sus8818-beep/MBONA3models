from sharedModel.kernelPerceptron import kernelPerceptron
from sharedModel.kernel import kernel

class model3(model2):
    def __init__(self, gamma, budget, phi, RmThreshold, spontaneousPhi):
        super(model3, self).__init__(gamma, budget, phi, RmThreshold)
        self.spontaneousShrinkRatio = spontaneousPhi

    def Out(self, x) -> NDArray[np.float64]:
        out = None
        for i in range(len(self.kernels)):
            if i==0:
                out = self.kernels[i].Out(x)
            else:
                out += self.kernels[i].Out(x)
        ## recover the winner kernel's sigma
        winnerKernel = self.getWinnerKernel()
        
        winnerKernel.resetSigma()
        self.Shrinkage(self.spontaneousPhi)
        return out

    
    def getWinnerKernel(self) -> kernel:
        winnerObj = max(self.kernels, key=lambda k: k.getLastExpout())
        return winnerObj
