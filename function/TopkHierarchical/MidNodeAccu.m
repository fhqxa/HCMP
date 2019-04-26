%% MidNodeAccu
% Written by Shunxin Guo
% 2019-04-21
%% Statistically predicting the correct rate of non-leaf nodes in the middle level.
function [MidAccu] = MidNodeAccu( LabelModPredict,LabelModTest,tree )
a = find(tree(:,2)==2);
root = find(tree(:,1)==0);
MidAccu = 0;
k=1;
for index = a: root-1
    if((~isempty(LabelModPredict{index}))&(~isempty(LabelModTest{index})))
        a = cellfun('length',LabelModPredict(:,index));   
        b = cellfun('length',LabelModTest(:,index));
        c = min(a,b);
        d = cell2mat(LabelModPredict(:,index));
        e = cell2mat(LabelModTest(:,index));
     
        num = 0;
    for ind = 1: c
        if (d(ind)==e(ind))
            num = num +1;
        end
    end
    
      MidAccu(:,k) = num/b; 
      k=k+1;
     end
end
end


