import matplotlib.pyplot as plt
import numpy as np
from tqdm import tnrange

from aes_sim import aes_internal, sbox
from powerModel import HW, calc_hamming_weight
from statsTools import cov, mean, std_dev

if __name__ == "__main__":

    test_1=HW[aes_internal(0xA7, 0x9b)] == 6
    test_2=HW[aes_internal(0x89, 0xe6)] == 3

    if test_1 and test_2:
        print("Correctly simulated AES! ")

    aes_traces_50_tracedata = np.load(r"traces/lab4_2_traces.npy")
    aes_traces_50_textindata = np.load(r"traces/lab4_2_textin.npy")
    key = np.load(r"traces/lab4_2_key.npy")

    trace_array = aes_traces_50_tracedata
    textin_array = aes_traces_50_textindata