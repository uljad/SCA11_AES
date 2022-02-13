import os

def getCipher_dir(directory="Simulations/ct"):

    line =[]
    cypher=[]
    names=[]

    directory = os.fsencode()

    for file in os.listdir(directory):

        filename = os.fsdecode(file)

        with open("C:/Users/ub352/Desktop/Spring2021/Capstone/Attack_CPA/ct/"+filename,'r') as f:
            names.append(filename)
            line=(f.readlines()) #loading cypher
            cypher.append(line)
        continue

    return cypher


def getPower_dir(directory="Simulations/power")
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
    
    return power

    