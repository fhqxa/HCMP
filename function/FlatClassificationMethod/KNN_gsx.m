function [k_acc] = KNN_gsx(data,numFolds)
    [M,~]=size(data);
    indices = crossvalind('Kfold',M,numFolds);
    rand('seed',1);
    for k = 1:numFolds
        test = (indices == k);
        train = ~test;
        train_data = data(train,1:end-1);
        train_label = data(train,end);
        test_data = data(test,1:end-1);
        test_label = data(test,end);
            
        mdl = ClassificationKNN.fit(train_data,train_label,'NumNeighbors', 3);   
        predict_label = predict(mdl, test_data);
        find_length = length(find(predict_label == test_label));
        accuracy_k(k) = find_length/length(test_label);
    end
    k_acc = mean(accuracy_k);  
end