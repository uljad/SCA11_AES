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
        
    cypher_floats=[]
    for k in cypher:
        container=[]
        for j in k:
            temp=j.strip()
            temp2="0x"+temp
            temp3=int(temp2,16)
            container.append(temp3)
        cypher_floats.append(container)
                
    return cypher_floats


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
    
    power_floats=[]
    for k in power:
        container=[]
        for j in k:
            temp=j.strip()
            temp2=float(temp)
            container.append(temp2)
        power_floats.append(container)

    return power_floats

