import os

import numpy as np
from matplotlib import pyplot as plt
from numpy import std
from scipy.stats import pearsonr

from hammWeight import hamming_weight
from StatisticsTools import Average, Covariance

line =[]
cypher=[]
names=[]



#
'''
Gettign the directory and loading the cypher

It is a list of 100 entries, each containing a list with the 5000 lines
'''

directory = os.fsencode("C:/Users/ub352/Desktop/Spring2021/Capstone/Attack_CPA/ct")

for file in os.listdir(directory):

    filename = os.fsdecode(file)

    with open("C:/Users/ub352/Desktop/Spring2021/Capstone/Attack_CPA/ct/"+filename,'r') as f:
        names.append(filename)
        line=(f.readlines()) #loading cypher
        cypher.append(line)
    continue



'''
Getting hamming weights of the cypher

It is a list of 100 entries, each containing a list with the 5000 lines

'''
h_w_line=[] #HW from one file
h_w_ct=[] # HW all together 

for k in cypher:
    for j in range(0,len(k)):

        hex_val="0x"+k[j][:-2] #getting the last two elements and adding the hex identifier
        temp=int(hex_val,16) #converting to int for the function
        h_w_line.append(hamming_weight(temp)) #calculating Hamming Weight

    h_w_ct.append(h_w_line)
    h_w_line=[]

print(len(h_w_ct[1])) #printing the length of the Hw list of one txt file

'''
Take the power traces

It is a list of 100 entries, each containing a list with the 5000 lines

'''
power_file=[]
power=[]

directory = os.fsencode("C:/Users/ub352/Desktop/Spring2021/Capstone/Attack_CPA/power")

for file in os.listdir(directory):

    filename = os.fsdecode(file)

    if filename.endswith("txt"):
        with open("C:/Users/ub352/Desktop/Spring2021/Capstone/Attack_CPA/power/"+filename,'r') as f:
            power_file=(f.readlines()) #loading power
            power.append(power_file)
        continue

print(len(power))

'''
CORRELATION FOR THE TWO HEX CHARACTERS
'''


corrs=[]
for i in range (0,len(power)):

    covariance=Covariance(power[i],h_w_ct[i])

    power_conv = []
    for h in power[i]:
        power_conv.append(float(h))
    
    # correlation=covariance/(std(np.array(power_conv))*std(h_w_ct[i]))
    correlation=pearsonr(power_conv,h_w_ct[i])
    corrs.append(correlation)

print(len(corrs))

print(corrs.index(max(corrs))) #finding the max

print(names[corrs.index(max(corrs))]) #finding from which file it is

plt.plot(corrs, linewidth=5)

plt.ylabel('correlation coeffs')
plt.xlabel('index connecting file and power trace')
plt.title('CPA Attack Output to find file with correct key')
plt.show()

print((corrs))

