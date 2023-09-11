clc;clear;

mac_array=[5,10,20];
d_array=[1,2];
mt_array=[3,9];
cplexUB=importdata ('cplex_UB.txt');

r=0;
j=20;
sample=20;
index=1;

res_table=zeros(12,12);

for i=1:numel(mac_array)
    for k=1:numel(d_array)
        for p=1:numel(mt_array)
            mac=mac_array(i);
            d=d_array(k);
            mt=mt_array(p);
            data=importdata (strcat('results\m',num2str(mac),'_j',num2str(j), ...
                '_d',num2str(d),'_mt',num2str(mt),'_r',num2str(r),'.txt'));
            end_time=mac*48;
            value_data=data(1:2:2*sample-1,:);
            time_data=data(2:2:2*sample,:);
            temp_logi=value_data>1.1*cplexUB(index);
            temp_logi=double(temp_logi);
            for aa=1:sample
                gap10Times(aa)=time_data(aa,sum(temp_logi(aa,:),2)+1);
            end
            [res_table(index,1),sigmaHat,res_table(index,2:3),sigmaCI] = normfit(gap10Times',0.05);
            
%             temp_logi=value_data>1.08*cplexUB(index);
%             for aa=1:sample
%                 gap5Times(aa)=time_data(aa,sum(temp_logi(aa,:),2)+1);
%             end
%             [res_table(index,4),sigmaHat,res_table(index,5:6),sigmaCI] = normfit(gap5Times',0.05);
% 
%             temp_logi=value_data>1.03*cplexUB(index);
%             for aa=1:sample
%                 gap3Times(aa)=time_data(aa,sum(temp_logi(aa,:),2)+1);
%             end
%             [res_table(index,7),sigmaHat,res_table(index,8:9),sigmaCI] = normfit(gap3Times',0.05);
% 
%             end_time_val=zeros(sample,1);
            index=index+1;
        end

    end
end

