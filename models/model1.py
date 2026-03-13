from sharedModel.kernelPerceptron import kernelPerceptron
from sharedModel.kernel import kernel

class model1(kernelPerceptron):
    def __init__(self, gamma, budget, phi, RmThreshold):
        super(model1, self).__init__(gamma)
        self.budget = budget
        self.phi = phi
        self.RmThreshold = RmThreshold

    def learning(self, x, y):
        if self.ClassificationErr(x,y) > 0:
            return
        if self.kernels.size() < self.budget:
            self.kernels.append(kernel.kernel(centroid, y, self.gamma))
        else:
            targetKernel = self.getOldestKernel(self)
            if targetKernel.sigma < self.RmThreshold:
                self.kernels.remove(targetKernel)
                self.kernels.append(kernel.kernel(centroid, y, self.gamma))
        self.Shrink(self.phi)

    def getOldestKernel(self) -> kernel:
        OldestObj = min(self.kernels, key=lambda k: k.sigma)
        return OldestObj

    def Shrink(self, phi):
        for eachKernel in self.kernels:
            eachKernel.decaySigma(phi)
            

    
