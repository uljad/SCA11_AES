import numpy as np

# Statistical Functions to be used in the CPA
def mean(X):
    return np.mean(X,axis=0)

def std_dev(X, X_bar):
    return np.sqrt(np.sum((X-X_bar)**2,axis=0))

def cov(X, X_bar, Y, Y_bar):
    return np.sum((X-X_bar)*(Y-Y_bar),axis=0)