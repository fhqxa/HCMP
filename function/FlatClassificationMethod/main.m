clear;clc;
tic
fold = 10;
load DD.mat;
% knn_all_acc = KNN_gsx(data_array,fold);
rf_all_acc = RF_gsx(data_array,fold);
t= toc;