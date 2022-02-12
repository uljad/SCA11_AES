import matplotlib.pyplot as plt
import numpy as np

from aes_sim import aes_internal, sbox
from powerModel import HW, calc_hamming_weight
from statsTools import cov, mean, std_dev

if __name__ == "__main__":

    #Check for simulation results
    test_1=HW[aes_internal(0xA7, 0x9b)] == 6
    test_2=HW[aes_internal(0x89, 0xe6)] == 3

    if test_1 and test_2:
        print("Correctly simulated AES! ")

    '''
    Import Traces==============================================================
    '''
    aes_traces_50_tracedata = np.load(r"traces/lab4_2_traces.npy")
    aes_traces_50_textindata = np.load(r"traces/lab4_2_textin.npy")
    key = np.load(r"traces/lab4_2_key.npy")

    trace_array = aes_traces_50_tracedata
    textin_array = aes_traces_50_textindata

    '''
    Plot Traces==============================================================
    '''
    plt.rcParams['figure.figsize'] = [10, 10]
    plt.plot(trace_array[0],'r--')
    plt.ylabel("Value")
    plt.title("Trace_Array")
    plt.savefig("CPA_output/traces.png",dpi=300)

    '''
    Attack Code ============================================================
    '''
    maxcpa = [0] * 256 #all zeros to start with
    #Using Python broadcasting
    t_bar = mean(trace_array) 
    o_t = std_dev(trace_array, t_bar)
    print(len(t_bar))

    # # Single Byte Loop
    # for kguess in range(0, 256):
    #     hws = np.array([[HW[aes_internal(textin[0],kguess)] for textin in textin_array]]).transpose()
    #     hws_bar=mean(hws)
    #     o_hws=std_dev(hws,hws_bar)
    #     cpaoutput = (cov(hws,hws_bar,trace_array,t_bar))/(o_t*o_hws)
    #     maxcpa[kguess] = cpaoutput
    
    # #get highest correlation and the responsible key byte

    # correlations=[np.max(np.abs(k)) for k in maxcpa]

    # guess=np.argmax(correlations)
    # guess_corr=np.max(correlations)

    # print("Key guess: ", hex(guess)," = ", guess)
    # print("Correlation: ", guess_corr)

    # ======================Full Byte Loop======================


    t_bar = np.sum(trace_array, axis=0)/len(trace_array)
    o_t = np.sqrt(np.sum((trace_array - t_bar)**2, axis=0))

    bestguess = [0] * 16 #put your key byte guesses here

    for bnum in range(0, 16):
        maxcpa = [0] * 256
        for kguess in range(0, 256):
            
            #Repeating the key byte guessing process from the last loop
            hws = np.array([[HW[aes_internal(textin[bnum],kguess)] for textin in textin_array]]).transpose()
            hws_bar=mean(hws)
            o_hws=std_dev(hws,hws_bar)
            cpaoutput = (cov(hws,hws_bar,trace_array,t_bar))/(o_t*o_hws)
            maxcpa[kguess] = cpaoutput
            
            #Get the highes correlation
            correlations=[np.max(np.abs(k)) for k in maxcpa]
            guess=np.argmax(correlations)
            guess_corr=np.max(correlations)

            #store the bytes
            bestguess[bnum]= guess

    '''
    Printing the Key ============================================================
    '''
    #Printing the Key       
    temp=[hex(k).split('x')[-1] for k in bestguess]
    final_key="0x"+''.join(temp)
    print("The Key is  ",final_key)