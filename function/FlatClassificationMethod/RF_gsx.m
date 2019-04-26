function [RF_acc] = RF_gsx(data,numFolds)
    [M,~]=size(data);
    indices = crossvalind('Kfold',M,numFolds);
    rand('seed',1);
    for k = 1:numFolds
        test = (indices == k);% Get the unit number of the test set element in the dataset
        train = ~test;
        train_data = data(train,1:end-1);%
        train_label = data(train,end);
        test_data = data(test,1:end-1);%//Test sample set
        test_label = data(test,end);
        
        nTree = 10;
        B = TreeBagger(nTree,train_data,train_label);
        predict_label_RF_cell = predict(B,test_data);
        
        [m,~] = size(predict_label_RF_cell);
        for j = 1:m
            predict_label(j,:) = str2num(predict_label_RF_cell{j,1});
        end
        find_length = length(find(predict_label == test_label));
        predict_label =[];
        accuracy_k(k) = find_length/length(test_label);
    end
    RF_acc= mean(accuracy_k);  
end