import numpy as np 

def calc_hamming_weight(n):
    return bin(n).count("1")

bit_vals=np.arange(0,256)
HW=[calc_hamming_weight(k) for k in bit_vals]

# def getHammimgWeight(text):

#     try: 
        


#     except ValueError:
#         try: 
#             for k in text:
#                 for j in range(0,len(k)):
#                     hex_val="0x"+k[j][:-2] #getting the last two elements and adding the hex identifier
#                     temp=int(hex_val,16) #converting to int for the function
#                     h_w_line.append(calc_hamming_weight(bin(temp))) #calculating Hamming Weight

#             h_w_ct.append(h_w_line)
#             h_w_line=[]


#     return w