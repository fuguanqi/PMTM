clc;clear;

mac_array=[5,10,20];
d_array=[1,2];
mt_array=[3,9];


r=0;
j=20;
for i=1:numel(mac_array)
    for k=1:numel(d_array)
        for p=1:numel(mt_array)
            mac=mac_array(i);
            d=d_array(k);
            mt=mt_array(P);
            n=data(2);
            prob.n=n;
            prob.d=d;
            prob.mt=mt;
            prob.r=r;
            data=importdata (strcat('INSTANCES\m',num2str(mac),'_j',num2str(j), ...
                '_d',num2str(d),'_mt',num2str(mt),'_r',num2str(r),'.txt'));
            prob.mac=mac;
            prob.p_i=data(3:n+2);
            prob.mt_j=data(n+3:n+2+mac);
            prob.deter=data(n+3+mac:end);
            prob.deter=reshape(prob.deter,[mac,n]);
            
            parfor aa=1:10
                [xbest, fbest] = SODAADM_DP(prob);
            end
        end
    end
end


