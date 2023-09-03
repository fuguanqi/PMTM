clc;clear;
mac=2;
j=10;
d=1;
mt=3;
r=0;

data=importdata (strcat('INSTANCES\m',num2str(mac),'_j',num2str(j), ...
    '_d',num2str(d),'_mt',num2str(mt),'_r',num2str(r),'.txt'));

n=data(2);
prob.n=n;
prob.mac=mac;
prob.p_i=data(3:n+2);
prob.mt_j=data(n+3:n+2+mac);
prob.deter=data(n+3+mac:end);
prob.deter=reshape(prob.deter,[mac,n]);



res = SODAADM_DP(prob);

