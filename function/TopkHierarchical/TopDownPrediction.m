%% Top-k prediction
% Written by Shunxin Guo
% 2018-11-29
%% Inputs:
% input_data: testing data without labels
% model: 
% tree: the tree hierarchy
% train_data: each fold of the training sample
% k: select the number of nodes
%% Output
 function [predict_label_KNN] = TopDownPrediction(input_data, model,tree,train_data,k)
% function [predict_label_RF] = TopDownPrediction(input_data, model, tree,train_data,k)    
    [m,~]=size(input_data);
    root = find(tree(:,1)==0);
    for j=1:m %The number of instances
%% Start at the root and select K nodes
        [~,~,d_v] = predict(1,sparse(input_data(j,:)), model{root}, '-b 1 -q');
        [n_d_v,IX]=sort(d_v,'descend');
        q = max(tree(:,2)); %%Record the number of layers in the tree
        for i =1:k
            currentNodeID = IX(1,i);
            mid_pro(i) = n_d_v(1,i);
            currentNode(i) = model{root}.Label(currentNodeID) ;
            currentNodeSelect(i,:)=[currentNode(i),mid_pro(i)];%
        end
%% Recursive middle level and select k nodes
        for index = 1: q-1
            currentNodeNew = [];
            for i = 1:k %
                currentNodeNew =[currentNodeNew; RecursiveLeaf(currentNodeSelect(i,:),input_data(j,:),model,tree,k)];
            end
            [n_d_v,IX]=sort(currentNodeNew(:,3),'descend');       
            currentNodeSelect(1:k,:) = currentNodeNew(IX(1:k,1),1:2); 
         end
%% Call classifier      
        [predict_label_KNN(j,:)] = KNN(input_data(j,:),currentNodeSelect(:,1),train_data,k);
%       [predict_label_RF(j,:)] = RandomForest(input_data(j,:),currentNodeSelect(:,1),train_data,k);
   end %%endfor    
end
