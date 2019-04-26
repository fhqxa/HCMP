%% 10-fold
%% Written by Hong Zhao
%% Modified by Shunxin Guo
% 2018-11-29
%% Inputs:
% data: all samples in the dataset
% numFolds: fold the number
% select_num: select the number of nodes
% tree: the tree hierarchy
%% Output
function [accuracyMean,accuracyStd,F_LCAMean,FHMean,MidAccuMean,TIEMean] = Kflod_TopDownClassifier(varargin)
if(length(varargin) == 4)
    data = varargin{1};
    numFolds = varargin{2};
    tree = varargin{3};
    select_num = varargin{4};
else
    if(length(varargin) == 5)
        data = [varargin{1},varargin{2}];
        numFolds = varargin{3};
        tree = varargin{4};
        select_num = varargin{5};
    end
end
[M,N]=size(data);
accuracy_k = zeros(1,numFolds);
rand('seed',1);
indices = crossvalind('Kfold',data(1:M,N),numFolds);%Random subcontracting,K-fold cross-validation,k=10
for k = 1:numFolds
    testID = (indices == k);
    trainID = ~testID;
    test_data = data(testID,1:end-1);
    test_label = data(testID,end);
    train_data = data(trainID,:);
    
    %% Creat sub table
    [trainDataMod, trainLabelMod] = creatSubTable(train_data, tree); 
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Train classifiers of all internal nodes
    numNodes = length(tree(:,1));%ZH: The total of all nodes.
    for i = 1:numNodes
        if (~ismember(i, tree_LeafNode(tree)))
            [model{i}]  = train(double(sparse(trainLabelMod{i})), sparse(sparse(trainDataMod{i})), '-c 2 -s 0 -B 1 -q');
        end
    end    
    %%           Prediction       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [predict_label] = TopDownPrediction(test_data, model, tree,train_data,select_num) ;
    %%          Envaluation       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   [PH(k), RH(k), FH(k)] = EvaHier_HierarchicalPrecisionAndRecall(test_label,predict_label,tree);
   [P_LCA(k),R_LCA(k),F_LCA(k)] = EvaHier_HierarchicalLCAPrecisionAndRecall(test_label,predict_label,tree);
   TIE(k) = EvaHier_TreeInducedError(test_label,predict_label,tree);
   accuracy_k(k) = EvaHier_HierarchicalAccuracy(test_label,predict_label, tree);
   LabelModPredict = creatSubTable_Y(predict_label, tree);
   LabelModTest = creatSubTable_Y(test_label, tree);
   [MidAccu(k,:)] = MidNodeAccu( LabelModPredict,LabelModTest,tree);
end
    accuracyMean = mean(accuracy_k);
	accuracyStd = std(accuracy_k);
    F_LCAMean = mean(F_LCA);
    FHMean = mean(FH);
    TIEMean = mean(TIE);
    MidAccuMean = mean(MidAccu);
end