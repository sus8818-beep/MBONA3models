from sharedModel.kernelPerceptron import kernelPerceptron
from sharedModel.kernel import kernel

class model1(kernelPerceptron):
    def __init__(self, gamma, budget, phi, RmThreshold):
        super(model1, self).__init__(gamma)
        self.budget = budget
        self.phi = phi
        self.RmThreshold = RmThreshold
        self.gamma = gamma
        
        self.DEBUG = False
        if self.DEBUG:
            print(f"model1.__init__() gamma: {self.gamma}, budget: {self.budget}, phi: {self.phi}, RmThreshold: {self.RmThreshold}")
            input("Press Enter to continue...")

    def learning(self, x, y):
        if self.DEBUG:
            print(f"model1.Learning() x: {x}, y: {y}")
        if self.ClassificationErr(x,y) < 0:
            if len(self.kernels) < self.budget:
                self.kernels.append(kernel(x, y, self.gamma))
            else:
                if self.DEBUG:
                    print(f"model1.Learning() remove oldest kernel")
                targetKernel = self.getOldestKernel()
                if targetKernel.sigma < self.RmThreshold:
                    self.kernels.remove(targetKernel)
                    self.kernels.append(kernel(x, y, self.gamma))
            self.Shrink(self.phi)

    def getOldestKernel(self) -> kernel:
        OldestObj = min(self.kernels, key=lambda k: k.sigma)
        return OldestObj

    def Shrink(self, phi):
        for eachKernel in self.kernels:
            eachKernel.decaySigma(phi)
            

    
