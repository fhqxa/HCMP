%% Random forest classifier is used to predict K selected nodes
% Written by Shunxin Guo
% 2018-11-29
%% Inputs:
% test_data: a piece of instance that needs to be tested
% predict_label: select the label by top-k 
% data: each fold of the training sample
% k: the tree hierarchy
%% Output
function [predict_label_RF] = RandomForest(test_data,predict_label,data,k)
Y=[];    
    for i = 1:k  %Selects all samples of the label of the selected node from the dataset
       Y_i= find(data(:,end) == predict_label(i)) ;
       Y = [Y;Y_i] ;
    end
    TrainData = data(Y,:);
    train_data = TrainData(:,1:end-1);
    train_label = TrainData(:,end);
    
    nTree =10;
    B = TreeBagger(nTree,train_data,train_label);
    predict_label_RF_cell = predict(B,test_data);
    predict_label_RF = str2num(predict_label_RF_cell{1,1});
end