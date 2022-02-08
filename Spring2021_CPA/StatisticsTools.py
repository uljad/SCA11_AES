def Average(lst):

    return sum(list(map(float,lst))) / len(lst)

def differences (x,y):

    difference=[]

    for i,j in zip(x,y):
        temp=float(i)-float(j)
        difference.append(temp)
    
    return difference 


def Covariance(x1, y1):
    # Finding the mean of the series x and y
    x = []
    for item in x1:
        x.append(float(item))

    y = []
    for item in y1:
        y.append(float(item))

    mean_x = sum(x)/float(len(x))
    mean_y = sum(y)/float(len(y))
    # Subtracting mean from the individual elements
    sub_x = [i - mean_x for i in x]
    sub_y = [i - mean_y for i in y]
    numerator = sum([sub_x[i]*sub_y[i] for i in range(len(sub_x))])
    denominator = len(x)-1
    cov = numerator/denominator
    return cov