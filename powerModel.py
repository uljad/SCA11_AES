import numpy as np 

def calc_hamming_weight(n):
    return bin(n).count("1")

bit_vals=np.arange(0,256)
HW=[calc_hamming_weight(k) for k in bit_vals]