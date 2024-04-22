%bisect kappa over [0,1]
delta=10e-8;%interval width tolerance
k1=0;k2=1;diff=1;%starting values
while diff>delta
    k3=0.5*(k1+k2);%find midpoint
    if any(any(wave1Ddamped(k3,0)<0)==1)%looks weird to get one value instead of a matrix
        k1=k3;
    else
        k2=k3;
    end
    diff=abs(k2-k1);
end
k1
k2
wave1Ddamped(k1,1);
