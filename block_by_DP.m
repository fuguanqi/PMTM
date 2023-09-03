function obj = block_by_DP(job_seq,assign,prob)

obj=0;

for i=1:prob.mac
    machines(i).jobs=[];
end

for i=1:prob.n
    j_id=job_seq(i);
    machines(assign(j_id)).jobs(end+1)=j_id;
end

max_makespan=0;
for i=1:prob.mac
    if numel(machines(i).jobs)==0
        continue;
    end
    memos=zeros(numel(machines(i).jobs),1);
    for k=1:numel(machines(i).jobs)
        memos(k)=dp(i,machines(i).jobs(1:k),prob,memos);
    end
    if max_makespan<memos(numel(machines(i).jobs))
        max_makespan=memos(numel(machines(i).jobs));
    end
end

obj=max_makespan;
end



function min_makespan=dp(m_id,job_seq,prob,memos)
num_job=numel(job_seq);
min_makespan=Inf;
old_block=[];
for block_first=num_job:-1:1
    [new_block,duration,isFull]=cal_block(old_block,job_seq(block_first),prob,m_id);
    if isFull==true
        return;
    end
    old_block=new_block;
    if block_first==1
        makespan=duration;
    else
        makespan=duration+prob.mt_j(m_id)+memos(block_first-1);
    end
    
    if makespan<min_makespan
        min_makespan=makespan;
    end
end

end


function [new_block,duration,isFull]=cal_block(old_block,new_job,prob,m_id)
%old block plus a new job inserted

isFull=false;
p_i=prob.p_i;
mt=prob.mt_j;
deter=prob.deter;
duration=0;
acc_deter=1;
new_job_prior=p_i(new_job)/(deter(m_id,new_job)-1);
new_block=[];

if numel(old_block)==0
    duration=p_i(new_job);
    new_block=[new_job];
    return;
end

pre_prior=Inf;
for i=1:numel(old_block)
    j_id=old_block(i);
    cur_prior=p_i(j_id)/(deter(m_id,j_id)-1);
    if pre_prior>=new_job_prior && new_job_prior>cur_prior
        duration=duration+p_i(new_job)*acc_deter;
        acc_deter=acc_deter*deter(m_id,new_job);
        new_block=[old_block(1:i-1),new_job,old_block(i:numel(end))];
    end
    if (acc_deter-1)*p_i(j_id)>mt(m_id)
        duration=Inf;
        new_block=[old_block,new_job];
        isFull=true;
        return;
    end
    duration=duration+p_i(j_id)*acc_deter;
    acc_deter=acc_deter*deter(m_id,j_id);
    if i==numel(old_block) && new_job_prior<=cur_prior
        new_block=[old_block,new_job];
        duration=duration+p_i(new_job)*acc_deter;
        if (acc_deter-1)*p_i(new_job)>mt(m_id)
            isFull=true;
            return;
        end
        acc_deter=acc_deter*deter(m_id,new_job);
        
    end 
end

end