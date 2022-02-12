import matplotlib.pyplot as plt
import numpy as np
from attack import guess_key

if __name__ == "__main__":

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


    '''
    Printing the Key ============================================================
    '''
    #Printing the Key       
    temp=[hex(k).split('x')[-1] for k in bestguess]
    final_key="0x"+''.join(temp)
    print("The Key is  ",final_key)