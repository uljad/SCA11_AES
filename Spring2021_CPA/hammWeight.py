def hamming_weight(x):
    """
    Compute the Hamming Weight of the given number
    :param x: Number you want to have the hamming weight of (integer)
    :return: athe Hamming weight (integer)
    """
    return bin(x).count("1")


