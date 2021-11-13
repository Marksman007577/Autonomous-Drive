%% testing different transfer functions for stability

zeros = [3 -6];
poles = [1 9 20];
system = tf(zeros, poles)
xteristic_equation = roots(poles)