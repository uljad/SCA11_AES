import numpy as np 
from statsTools import mean,std_dev,cov
from aes_sim import aes_internal, sbox
from powerModel import HW, calc_hamming_weight

def simple_guess(trace_array)

    maxcpa = [0] * 256 #all zeros to start with
    #Using Python broadcasting
    t_bar = mean(trace_array) 
    o_t = std_dev(trace_array, t_bar)
    print(len(t_bar))

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
    
    return bestguess