from sharedModel.kernelPerceptron import kernelPerceptron
from sharedModel.kernel import kernel

class model3(model2):
    def __init__(self, gamma, budget, ErrThreshold, ShrinkRatio, RmThreshold, spontaneousShrinkRatio):
        super(model3, self).__init__(gamma, budget, ErrThreshold, ShrinkRatio, RmThreshold)
        self.spontaneousShrinkRatio = spontaneousShrinkRatio

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
        self.Shrinkage(self.spontaneousShrinkRatio)
        return out

    
    def getWinnerKernel(self) -> kernel:
        winnerObj = max(self.kernels, key=lambda k: k.getLastExpout())
        return winnerObj
