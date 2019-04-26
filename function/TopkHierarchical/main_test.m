 %% Top-k classification with tree hierarchy in Madantory Leaf Node Prediction.
%% Train a multi-class logistic regression classifier for each node,k nodes were selected and classified by classifier.
%% Usage: change the input dataSat on the top,
%%        and you can change the proportion of data for training and testing at parameter 'numFolds'.
%% For performance of the classifier, change the cmd parameter in KNN.m
%% For evaluation metrics, accuracyMean is accuracy.

clear;
clc;
%% Load information of the dataset
load DD.mat;
tic
numFolds = 10;
k = 2;
[accuracyMean,accuracyStd,F_LCAMean,FHMean,MidAccuMean,TIEMean] = Kflod_TopDownClassifier(data_array,numFolds,tree,k);
t=toc;
