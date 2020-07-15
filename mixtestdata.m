function [data] = mixtestdata(test_data,trls,img_m,img_n)

%s=sqrt(size(test_data,2));     % Calculate image size
I= zeros(img_m,img_n);             % create an image matrix
num_class   = length(unique(trls));% 

data = [];    % Create a new matrix to save the processed data
for ci = 1:num_class   

tr_dat_ci   =   test_data(trls==ci,:); 

x=size(tr_dat_ci ,1);       
y=img_m*img_n;       % create a matrix to save the feature    
feature=zeros(x,y);  
x1=round(x/3);     % slip the dataset into three parts
x2=round(x/3)+1;
x3=round(2*x/3);
x4=round(2*x/3)+1;

for num=1:x1
for i=1:img_m
    for j=1:img_n
a=img_n*(i-1)+j;
I(i,j)=tr_dat_ci (num,a);
    end
    
end

J= impyramid(I, 'reduce');
J =impyramid(J,'reduce');
J =impyramid(J,'expand');
J =impyramid(J,'expand');
J=imresize(J,[img_m,img_n]);
[m,n] = size(J);

for ii=1:m
    for jj=1:n
b=n*(ii-1)+jj;
feature(num,b) = J(ii,jj);
    end  
end
end

for num=x2:x3
for i=1:img_m
    for j=1:img_n
a= img_n*(i-1)+j;
I(i,j)=tr_dat_ci (num,a);
    end
    
end

J=I;
[m,n] = size(J);

for ii=1:m
    for jj=1:n
b=n*(ii-1)+jj;
feature(num,b) = J(ii,jj);
    end  
end
end



for num=x4:x
for i=1:img_m
    for j=1:img_n
a=img_n*(i-1)+j;
I(i,j)=tr_dat_ci(num,a);
    end
    
end
J= impyramid(I, 'reduce');
J =impyramid(J,'expand');
J=imresize(J,[img_m,img_n]);
[m,n] = size(J);

for ii=1:m
    for jj=1:n
b=n*(ii-1)+jj;
feature(num,b) = J(ii,jj);
    end  
end
end

data =[data;feature];  

end
%------------normalization---------------------------------------------------
for kk=1:size(data,1)
    data(kk,:)=data(kk,:)/norm(data(kk,:));
end