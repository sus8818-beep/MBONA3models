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

    # classification error function. If KernelPerceptron yields correct outputs, it returns a positive value, otherwise it returns a negative value.
    def ClassificationErr(self, x, y) -> float:
        Y = self.Out(x)
        DesiredY = np.array(y)
        prod = np.prod(Y * DesiredY)
        return prod

    '''
    def SquaredError(self, x, y) -> float:
        Y = self.Out(x)
        desiredY = np.array(y)
        diff = np.linalg.norm(Y-desiredY)
        Err = diff ** 2.
        return Err
    '''
        
