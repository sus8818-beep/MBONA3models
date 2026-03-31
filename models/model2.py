# model2.py
# Please make sure that class model2 extends class model1.
# Although method Out() is not included in this source file, model2.Out() is the same as model1.Out().
# The method learning() is overlided.

from .model1 import model1
from sharedModel.kernel import kernel

class model2(model1):
    def __init__(self, gamma, budget, phi):
        super(model2, self).__init__(gamma, budget, phi, 1.0) # note: RmThreshold is set to 1.0, which effectively disables the threshold-based removal in model1

    def learning(self, x, y):
        if self.ClassificationErr(x,y) > 0:
            return
        self.kernels.append(kernel(x, y, self.gamma))
        self.Shrink(self.phi)
        if len(self.kernels) > self.budget:
            targetKernel = self.getOldestKernel()
            self.kernels.remove(targetKernel)
