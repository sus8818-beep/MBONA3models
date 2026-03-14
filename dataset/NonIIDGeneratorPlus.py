import random
#import os
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import multivariate_normal
import copy
from pandas._libs import index

class NonIIDGenerator:
    def __init__(self, inputdim=5, sigma=0.01, NumberOfClusters=20, NumberOfSamples=100, distanceBetweenClusters=0.8,
                 RecursiveRatio=0.1, ChangeRatio=0.5, filename='data.csv'):
        self.DEBUG = True
        self.means = []
        self.labels = []
        
        self.inputs = []
        self.outputs = []
        
        self.NumberOfClusters=NumberOfClusters
        self.NumberOfSamples =NumberOfSamples
        self.sigma = sigma
        self.inputdim = inputdim
        self.distanceBetweenClusters = distanceBetweenClusters
        
        self.RecursiveRatio=RecursiveRatio
        self.ChangeRatio=ChangeRatio
        self.filename=filename
        
        self.means, self.labels = self.generateMeanAndLabel(self.inputdim, self.NumberOfClusters, self.distanceBetweenClusters)
        self.inputs, self.outputs = self.generateSamples(self.means, self.labels, self.RecursiveRatio, self.ChangeRatio)
        self.positions = self.generatePositions(pos_dim=self.inputdim, NumberOfClusters=self.NumberOfClusters, distanceBetweenPositions=self.distanceBetweenClusters)
        self.saveGeneratedSamples(self.inputs, self.outputs, self.filename)
        
    def generateMeanAndLabel(self, inputdim, NumberOfClusters, distanceBetweenClusters):
        means = []
        labels = []

        for i in range(NumberOfClusters):
            #ラベルを作る
            label = np.zeros(NumberOfClusters)
            for j in range(NumberOfClusters):
                label[j] = -1
            label[i] = 1 # i番目の要素だけを１にする
            if self.DEBUG:
                print("NonIIDGenerator.__init__() label=",label)
            labels.append(copy.deepcopy(label))


            if i==0:
                #ランダムな入力ベクトルを作る
                random_number = random.sample(range(10),inputdim)
                if self.DEBUG:
                    print("NonIIDGenerator.generateMeanAndLabel() 1st random_number=", random_number)
                random_number = np.divide(random_number, 10)
                means.append(random_number)
            else:
                min_dis = 0
                while (min_dis < distanceBetweenClusters):
                    #ランダムな入力ベクトルを作る
                    random_number = random.sample(range(10),inputdim)
                    random_number = np.divide(random_number, 10)
                    if self.DEBUG:
                        print("NonIIDGenerator.generateMeanAndLabel() random_number=", random_number)
                    __, min_dis = self.find_closest_vector_index(means, random_number)
                means.append(random_number)
        return means, labels

    def generatePositions(self, pos_dim, NumberOfClusters, distanceBetweenPositions):
        positions = []

        for i in range(NumberOfClusters):
            if i == 0:
                # 最初の位置ベクトル
                random_number = np.divide(random.sample(range(10), pos_dim), 10)
                positions.append(random_number)
            else:
                min_dis = 0
                while min_dis < distanceBetweenPositions:
                    random_number = np.divide(random.sample(range(10), pos_dim), 10)
                    _, min_dis = self.find_closest_vector_index(positions, random_number)
                positions.append(random_number)

        return positions
    
    def find_closest_vector_index(self, vectors, target):
    # ベクトルのリストとターゲットベクトルをnumpy配列に変換
        vectors = np.array(vectors)
        target = np.array(target)
    
        # ターゲットベクトルと配列内の各ベクトル間のユークリッド距離を計算
        distances = np.linalg.norm(vectors - target, axis=1)
    
        # 最も近いベクトルのインデックスを見つける
        closest_index = np.argmin(distances)
    
        # 最も近いベクトルを返す
        return closest_index, distances[closest_index]

    def boltzmann_transition(self, previous_index, temperature=0.1):
        prev_pos = np.array(self.positions[previous_index])

        distances = np.linalg.norm(np.array(self.positions) - prev_pos, axis=1)

        weights = np.exp(-distances / temperature)
        probs = weights / np.sum(weights)

        next_index = np.random.choice(len(self.positions), p=probs)
        return next_index

    def generateSamples(self, means, labels, recursiveRatio, changeRatio):
        inputs = []
        outputs = []
        previous_index = 0
        myConv=self.createDiagCovarianceMatrix(self.sigma, self.inputdim)
        if self.DEBUG:
            print("NonIIDGenerator.generateSamples() myConv=", myConv)
            print("NonIIDGenerator.generateSamples() means=", means)
            
        for i in range(self.NumberOfSamples):
            #index = self.NonIIDsampleIndex(previous_index, stay_prob=recursiveRatio, change_ratio=changeRatio)
            index = self.boltzmann_transition(previous_index, temperature=ChangeRatio)
            previous_index = index #今のindexを一つ前のパターンとして記憶
            each_pattern = np.random.multivariate_normal(means[index], myConv, 1)
            if self.DEBUG:
                print("NonIIDGenerator.generateSamples() recursive_ratio=%s, change_ratio=%s" %(recursiveRatio,changeRatio))
                print("NonIIDGenerator.generateSamples() each_pattern-index=", index)
            inputs.append(each_pattern ) 
            outputs.append(copy.deepcopy(labels[index]))    
        return inputs, outputs    
    
    
    def saveGeneratedSamples(self, inputs, outputs, filename):  
        delimiter = ','
        if self.DEBUG:
            print("NonIIDGenerator.saveGeneratedSamples() inputs=", inputs)
        with open(filename, mode='w') as f:
            s = ""
            for n in range(len(inputs)):
                for i in range(self.inputdim):
                    s = s + str(inputs[n][0][i])
                    s = s+delimiter
                        
                for o in range(self.NumberOfClusters):
                    s = s + str(outputs[n][o])
                    if o < self.NumberOfClusters-1:
                        s = s + delimiter
                    else:
                        s = s + "\n"                   
            f.write(s)
    

    def createDiagCovarianceMatrix(self, sigma, inputdim):
        """
        Args:
          sigma:
          inputdim:

        Returns:

        """
        eachLow = []
        CovMatrix = []
        for j in range(inputdim):
            eachLow = []
            for i in range(inputdim):
                if i==j:
                    eachLow.append(sigma)
                else:
                    eachLow.append(0.0)
            CovMatrix.append(eachLow)
        print("createDiagCovarianceMatrix() ", CovMatrix)
        return CovMatrix
    
        #非独立サンプル系列を生成する（確率prob(%)で一つ前と同じサンプルになる.環境の変化の激しさを表現）
    def NonIIDsampleIndex(self, previous_index, stay_prob=20, change_ratio=0.2):
        ratio = random.sample(range(100),1) #１から１００までの乱数を生成
        print("NonIIDsampleIndex() ratio=", ratio)
        print("NonIIDsampleIndex() stay_prob=", stay_prob)
        index = previous_index
        if ratio[0] < stay_prob: #乱数の値が100-prob以上のとき(確率100-prob％)
            index = previous_index #以前の学習サンプルのままにする。
        elif ratio[0] < stay_prob+int((100-stay_prob)*change_ratio):
            index = index + 1 #次の学習サンプルにチェンジ
            if index > self.NumberOfClusters-1:
                index = 0
        else:
            index = index - 1
            if index < 0:
                index = self.NumberOfClusters-1
        return index
    
if __name__ == "__main__":
    for stayRatio in [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]:
        for n in range(50):
            filename = "data" + str(stayRatio) + "-0.5-" + str(n) + ".csv"
            NonIIDGenerator(inputdim=5, sigma=0.01, NumberOfClusters=40, NumberOfSamples=2000, distanceBetweenClusters=0.5,
                 RecursiveRatio=stayRatio, ChangeRatio=0.5, filename=filename)
