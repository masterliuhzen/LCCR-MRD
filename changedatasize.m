function [data] = changedatasize(test_data,res_m,res_n,imgsize_m,imgsize_n)

I= zeros(res_m,res_n);     % create image matrix
x=size(test_data,1);       % the number of images
y=imgsize_m*imgsize_n;     % create a matrix to save the changed image
feature=zeros(x,y);

for num=1:x
    for i=1:res_m
        for j=1:res_n
            a=res_n*(i-1)+j;
            I(i,j)=test_data(num,a);
        end
    
    end

    J=imresize(I,[imgsize_m,imgsize_n]);
    [m,n] = size(J);

    for ii=1:m
        for jj=1:n
            b=n*(ii-1)+jj;
            feature(num,b) = J(ii,jj);
        end  
    end
end
data=feature;
%------------normalization---------------------------------------------------
for kk=1:size(data,1)
    data(kk,:)=data(kk,:)/norm(data(kk,:));
end