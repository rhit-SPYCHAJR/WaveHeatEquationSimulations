function[soln] = wave1Ddamped(kappa,plot)
%wave1D Code for Ch.11 problem 2

L=2;T=30;
dx=0.01;dt=0.028;
Xvals=unique([0:dx:L,L]);
Tvals=unique([0:dt:T,T]);

soln=zeros(length(Xvals),length(Tvals));
soln(:,2) = (exp(-10*(Xvals-(L/2)).^2) - exp(-10*(L/2).^2))*dt;

alpha=0.1;%H/rho
beta=1/(1+kappa*dt);
gamma=2+kappa*dt;
r=alpha*(dt^2)/(dx^2);
i=2:length(Xvals)-1;
for j=3:length(Tvals)
    soln(i,j)=beta*(gamma*soln(i,j-1)-soln(i,j-2)+r*(soln(i+1,j-1)-2*soln(i,j-1)+soln(i-1,j-1)));
end

if plot==1
    mesh(soln);
    zlim([-0.1 0])
end