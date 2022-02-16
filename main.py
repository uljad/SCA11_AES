import matplotlib.pyplot as plt
import numpy as np
from attack import guess_no_pt, simple_guess
from handler import getCipher_dir,getPower_dir

if __name__ == "__main__":

    '''
    Import Traces==========================================================================================
    '''
    aes_traces_50_tracedata = np.load(r"JupyterNotebooks/traces/lab4_2_traces.npy")
    aes_traces_50_textindata = np.load(r"JupyterNotebooks/traces/lab4_2_textin.npy")
    key = np.load(r"JupyterNotebooks/traces/lab4_2_key.npy")

    trace_array = aes_traces_50_tracedata
    textin_array = aes_traces_50_textindata

    cipher=getCipher_dir()
    power=getPower_dir()

    print(cipher[0][0], end = '')
    print("---------------\n")
    print((power[0][0]))
    print(type(power[0][0]))
    print(type(cipher[0][0]))



    '''
    Plot Traces=============================================================================================
    '''
    plt.rcParams['figure.figsize'] = [40, 15]
    plt.plot(power[0],'g-')
    plt.ylabel("Value")
    plt.title("Trace_Array")
    plt.savefig("CPA_output/traces.png",dpi=300)

    '''
    Attack Code ============================================================================================
    '''
    bestguess=simple_guess(trace_array,textin_array)
    guess_sim=guess_no_pt(power,cipher)


    '''
    Printing the Key ======================================================================================
    '''
    #Printing the Key       
    temp=[hex(k).split('x')[-1] for k in bestguess]
    final_key="0x"+''.join(temp)
    print("The Key is  ",final_key)

    final_key=""

    temp=[hex(k).split('x')[-1] for k in guess_sim]
    final_key="0x"+''.join(temp)
    print("The Key from simulation is  ",final_key)

