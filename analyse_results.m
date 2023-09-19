clc;clear;

mac_array=[5,10];
d_array=[1,2];
mt_array=[3,9];
cplexUB=importdata ('cplex_UB.txt');

r=0;
j=20;
sample=15;
index=1;

res_table=zeros(8,12);

for i=1:numel(mac_array)
    for k=1:numel(d_array)
        for p=1:numel(mt_array)
            mac=mac_array(i);
            d=d_array(k);
            mt=mt_array(p);
            data=importdata (strcat('results\m',num2str(mac),'_j',num2str(j), ...
                '_d',num2str(d),'_mt',num2str(mt),'_r',num2str(r),'.txt'));
            end_index=mac*32+1;%eval= (这个数/4)*#job
            value_data=data(1:2:2*sample-1,:);
            time_data=data(2:2:2*sample,:);

            
            
            res_table(index,1)=min(value_data(:,end_index));
            res_table(index,2)=max(value_data(:,end_index));
            res_table(index,3)=mean(value_data(:,end_index));
            res_table(index,4)=mean(time_data(:,end_index));
            
            base=min(cplexUB(index),res_table(index,1));
            res_table(index,1:3)=(res_table(index,1:3)-base)/base;
            
            index=index+1;
        end

    end
end

