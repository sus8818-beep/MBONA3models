from sharedModel.kernelPerceptron import kernelPerceptron
from sharedModel.kernel import kernel

class model1(kernelPerceptron):
    def __init__(self, gamma):
        super(model1, self).__init__(gamma)

    def learning(self, x, y):
        self.kernels.append(kernel.kernel(centroid, y, self.gamma))
        self.sigma.append(1.0)
