%% KNN classifier is used to predict k selected nodes
% Written by Shunxin Guo
% 2018-11-29
%% Inputs:
% test_data: a piece of instance that needs to be tested
% predict_label: select the label by top-k 
% data: each fold of the training sample
% k: the tree hierarchy
%% Output
function [predict_label_KNN] = KNN(test_data,predict_label,data,k)
Y=[];    
    for i = 1:k    %Selects all samples of the label of the selected node from the dataset
       Y_i= find(data(:,end) == predict_label(i)) ;
       Y = [Y;Y_i] ;
    end
    TrainData = data(Y,:);
    train_data = TrainData(:,1:end-1);
    train_label = TrainData(:,end);
   
    mdl = ClassificationKNN.fit(train_data,train_label,'NumNeighbors',1);   
    predict_label_KNN = predict(mdl, test_data);
end