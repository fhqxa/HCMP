 %% Top-K classification with tree hierarchy in Madantory Leaf Node Prediction.
%% Train a multi-class logistic regression classifier for each node,K nodes were selected and classified by classifier.
%% Usage: change the input dataSat on the top,
%%        and you can change the proportion of data for training and testing at parameter 'numFolds'.
%% For performance of the classifier, change the cmd parameter in KNN.m
%% For evaluation metrics, accuracyMean is accuracy.

clear;
clc;
%% Load information of the dataset

dataSetCand = {'DD'};
ds = 1;
    dataSet = dataSetCand{ds};
    dataSetTest = [dataSet '.mat'];
    dataTest = importdata(dataSetTest);
   
tic
numFolds = 10;
k = 2; % Number of paths
[accuracyMean,accuracyStd,F_LCAMean,FHMean,TIEMean,PredLabel,RealLabel] = Kflod_TopKClassifier( dataTest.data_array,numFolds,dataTest.tree,k);
t=toc;