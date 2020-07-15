function [res_m,res_n,data] = changeResolution(test_data, dir,imgsize_m,imgsize_n)
if dir==0
	direction='reduce';
elseif dir ==1
	direction='expand';
end
 
% Initialization variable
I= zeros(imgsize_m,imgsize_n);   % create an image matrix
x=size(test_data,1);       % the number of images
for i=1:imgsize_m
    for j=1:imgsize_n
        a=imgsize_n*(i-1)+j;
        I(i,j)=test_data(1,a);
    end
end

% create a matrix to save the changed image
J= impyramid(I, direction);
[m,n] = size(J);
y=m*n;
feature=zeros(x,y);

% read image
for num=1:x
    for i=1:imgsize_m
        for j=1:imgsize_n
            a=imgsize_n*(i-1)+j;
            I(i,j)=test_data(num,a);
        end
    end

    % change resolution
    J= impyramid(I, direction);
    % output iamge
    for ii=1:m
        for jj=1:n
            b=n*(ii-1)+jj;
            feature(num,b) = J(ii,jj);
        end  
    end
end
data=feature;
res_m=m;
res_n=n;