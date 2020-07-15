
function [train_data,train_data_label,test_data,test_data_label]=readdata(train_num,cnum)

load LFW__32x32_r

k=train_num;    
samplenum=size(labelMat,2);
Class = size(labelMat,1);  

train_data=zeros(Class*k,size(featureMat,1));
test_data=zeros(samplenum-Class*k,size(featureMat,1));

eachClass=zeros(Class,1);
for i=1:Class
for jj=1:samplenum
   if(labelMat(i,jj)==1)
     eachClass(i)=eachClass(i)+1;
   end
 end %jj
end %i
 
mk=0;
m=0;
for j=1:Class

randIdx=randperm(eachClass(j));
b_train=randIdx(1:k);
b_test=randIdx(k+1:eachClass(j));
train_num=mk+b_train;
test_num=mk+b_test;

temp1=featureMat(:,train_num);
temp2=featureMat(:,test_num);
train_data(((j-1)*k+1):((j-1)*k+k),:)=temp1';
train_data_label(((j-1)*k+1):((j-1)*k+k),1)=j;
p=eachClass(j,1)-k;

test_data(m+1:m+p,:)=temp2';
test_data_label(m+1:m+p,1)=j;
m=m+(eachClass(j,1)-k);
mk=mk+eachClass(j);
end % j


% for kk=1:size(train_data,1)
%    train_data(kk,:)=train_data(kk,:)/norm(train_data(kk,:));
% end
% 
% %--------------------------------------------------------------------------
% 
% for kkk=1:size(test_data,1)
%     test_data(kkk,:)=test_data(kkk,:)/norm(test_data(kkk,:));
% end
% 
% %--------------------------------------------------------------------------

