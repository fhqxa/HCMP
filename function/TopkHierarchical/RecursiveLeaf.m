%% Node selection
% Written by Shunxin Guo
% 2018-11-29
%% Inputs:
% acc: the nodes selected and the probability of nodes
% input_data: training data without labels
% model: 
% tree: the tree hierarchy
%% Output
function[select] = RecursiveLeaf(acc,input_data,model,tree,k)
currentNode = acc(1,1);
currentNodeAcc = acc(1,2);
       if(~ismember(currentNode,tree_LeafNode(tree)))
           [~,~,d_v] = predict(1,sparse(input_data),model{currentNode}, '-b 1 -q');
           [n_d_v,IX]=sort(d_v,'descend');
           currentParentNode = currentNode;
           for i = 1:k
               currentNodeID = IX(1,i);
               mid_pro = n_d_v(1,i);
               currentNode = model{currentParentNode}.Label(currentNodeID);
               acc(i,:) = [currentNode,mid_pro];
               select(i,:) = [currentNode,mid_pro,currentNodeAcc * acc(i,2)]; %Stores the product of the probabilities of a child node and its parent node
           end
       end
end