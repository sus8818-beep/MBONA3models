import kernel
from numpy.typing import NDArray

class kernelPerceptron:
    def __init__(self, gamma):
        self.gamma = gamma
        self.kernels = []

    def learning(self, x, y):
        self.kernels.append(kernel.kernel(centroid, y, self.gamma))
        self.sigma.append(1.0)

    def decaySigma(self, decayRate):
        for i in range(len(self.sigma)):
            self.kernels[i].decaySigma(decayRate)
            
    def Out(self, x) -> NDArray[np.float64]:
        out = None
        for i in range(len(self.kernels)):
            if i==0:
                out = self.kernels[i].Out(x)
            else:
                out += self.kernels[i].Out(x)
        return out
