clc;clear;
m=20;
j=20;
d=1;
mt=3;
r=1;

data=importdata (strcat('INSTANCES\m',num2str(m),'_j',num2str(j), ...
    '_d',num2str(d),'_mt',num2str(mt),'_r',num2str(r),'.txt'));

n=data(2);
prob.n=n;
prob.m=m;
prob.p_i=data(3:n+2);
prob.mt_j=data(n+3:n+2+m);
prob.deter=data(n+3+m:end);
prob.deter=reshape(prob.deter,[m,n]);



res = SODAADM_DP(prob);

