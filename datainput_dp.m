
function y=datainput_dp(xx) %objective function
x=xx'; % make sure vector is row vector
load (strcat('temp_data\Data1.mat'));

job_seq=[0,1,0];
assign=zeros(n,1);


for i=1:n-1
    job_seq=[job_seq(1:x(i)) i+1 job_seq(x(i)+1:end)];
end
job_seq=job_seq(2:end-1);


for i=1:n
    assign(i)=x(i+n-1);
end


y=block_by_DP(job_seq,assign,prob);


end %
