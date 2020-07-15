% =========================================================================
% Zhen Liu, Xiao-Jun Wu, and Zhenqiu Shu,
% "Weighed collaborative representation with multi-resolution dictionary for face recognition" in ICPR2020.
%
% Written by Zhen Liu @ JNU
% July, 2020.
% =========================================================================

clear; clc; close all
c = 158;% The class number of training samples


imgsize_m = 32;% image size
imgsize_n = 32;

iterations = 10;  %iteration number

% repeat the experiment ten times
for train_num = 5
    for lambda = 0.01 %[100 10 1 0.1 0.01 0.001 0.0001 0.00001]
        for iter = 1:iterations
            [train_data3,train_label,test_data,test_label]=readdata(train_num,c); % input data
            
            % convert the trainning set into different resolutions
            [train_data3]=changedatasize(train_data3,imgsize_m,imgsize_n,imgsize_m,imgsize_n);
            [res_m,res_n,train_data2] = changeResolution(train_data3,0,imgsize_m,imgsize_n);
            [res_m,res_n,train_data2] = changeResolution(train_data2,1,res_m,res_n);
            [train_data2]=changedatasize(train_data2,res_m,res_n,imgsize_m,imgsize_n);
            [res_m,res_n,train_data4] = changeResolution(train_data3,0,imgsize_m,imgsize_n);
            [res_m,res_n,train_data4] = changeResolution(train_data4,0,res_m,res_n);
            [res_m,res_n,train_data4] = changeResolution(train_data4,1,res_m,res_n);
            [res_m,res_n,train_data4] = changeResolution(train_data4,1,res_m,res_n);
            train_data4=changedatasize(train_data4,res_m,res_n,imgsize_m,imgsize_n);
            
            % convert the test set into different resolutions
            test_data = mixtestdata(test_data,test_label,imgsize_m,imgsize_n);
            
            train_data2 = train_data2';
            train_data3 = train_data3';
            train_data4 = train_data4';
            test_data = test_data';
            test_label = test_label';
            train_label = train_label';
              
            traindata = [train_data3,train_data2,train_data4];
            N_indTest =  size(test_data,2);
            N_traindata = size(traindata,2);
            NUm = size(train_data3,2);
             
            ID=[];
            tic;
            for indTest = 1:N_indTest
                G = [];
                for indTrain = 1:N_traindata
                    [g]     =   norm(test_data(:,indTest)-traindata(:,indTrain));
                    G       =   [G g];
                end
               
                W = G;
                W = diag(G/max(G));
                
                T = inv(traindata'*traindata +lambda*W'*W)*traindata';
                [id]    =   Classification_WCRMRD(train_data3,train_data2,train_data4,T,test_data(:,indTest),train_label,NUm);
                ID      =   [ID id];
            end

            cornum      =   sum(ID==test_label);
            accracy =   [cornum/length(test_label)];
            
            time_WCRWRD = toc/N_indTest;
            fprintf(['train_num=' num2str(train_num) ' lambda=' num2str(lambda) ' accracy=' num2str(accracy)  ' time=' num2str(time_WCRWRD) '\n']);
            acc(iter,1) = accracy;
            TIME(iter,1) = time_WCRWRD;
            iter = iter + 1 ;
        end
        Ravg = mean(acc);
        Rstd = std(acc);
        Tavg = mean(TIME);
        Tstd = std(TIME);
        fprintf(['train_num=' num2str(train_num) ' lambda=' num2str(lambda) ' Ravg=' num2str(Ravg)  ' Rstd=' num2str(Rstd)  ' Tavg=' num2str(Tavg) ' Tstd=' num2str(Tstd)  '\n']);
    end
end
