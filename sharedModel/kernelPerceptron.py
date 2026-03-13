from . import kernel
import numpy as np
from numpy.typing import NDArray

class kernelPerceptron:
    def __init__(self, gamma):
        self.gamma = gamma
        self.kernels = []
        self.DEBUG = False

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
                if self.DEBUG:
                    print(f"kernelPerceptron.Out() Adding output from kernel {i}: {self.kernels[i].Out(x)}")
                out += self.kernels[i].Out(x)
        return out

    # classification error function. If KernelPerceptron yields correct outputs, it returns a positive value, otherwise it returns a negative value.
    def ClassificationErr(self, x, y) -> float:
        Y = self.Out(x)
        if self.DEBUG:
            print(f"kernelPerceptron.ClassificationErr() LearnerOutput: {Y}, Desired: {y}")
        if Y is None:
            # no kernels yet, treat as error
            return -1.0
        DesiredY = np.array(y)
        for i in range(len(Y)):
            if Y[i] * DesiredY[i] <= 0:
                # if any output is incorrect, return negative error
                return -1.0
        return 1.0

    '''
    def SquaredError(self, x, y) -> float:
        Y = self.Out(x)
        desiredY = np.array(y)
        diff = np.linalg.norm(Y-desiredY)
        Err = diff ** 2.
        return Err
    '''
        
