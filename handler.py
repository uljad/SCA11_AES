import os

def getCipher_dir(dir="Simulations/ct"):

    line =[]
    cypher=[]
    names=[]

    directory = os.fsencode(dir)

    for file in os.listdir(directory):

        filename = os.fsdecode(file)

        with open("C:/Users/ub352/Desktop/Spring2021/Capstone/Attack_CPA/ct/"+filename,'r') as f:
            names.append(filename)
            line=(f.readlines()) #loading cypher
            cypher.append(line)
        
        for k in cypher:
            for j in k:
                temp=j[:-1]
                j=temp
                

    return cypher


def getPower_dir(dir_="Simulations/power"):
    power_file=[]
    power=[]

    directory = os.fsencode(dir_)

    for file in os.listdir(directory):

        filename = os.fsdecode(file)

        if filename.endswith("txt"):
            with open("C:/Users/ub352/Desktop/Spring2021/Capstone/Attack_CPA/power/"+filename,'r') as f:
                power_file=(f.readlines()) #loading power
                power.append(power_file)
            
            
        for k in power:
            for j in k:
                temp=j[:-1]
                j=temp

    return power

