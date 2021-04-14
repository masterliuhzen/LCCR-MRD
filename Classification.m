function [id]= Classification(D1,D2,D3,class_pinv_M,y,Dlabels,Num)
coef         =  class_pinv_M*y;
coef_a1 =  coef(1:Num);
coef_a2 =  coef(Num+1:2*Num);
coef_a3 =  coef(2*Num+1:end);
    
for ci = 1:max(Dlabels)
    a1        =  coef_a1(Dlabels==ci);
    a2        =  coef_a2(Dlabels==ci);
    a3        =  coef_a3(Dlabels==ci);
    Dc1       =  D1(:,Dlabels==ci);
    Dc2       =  D2(:,Dlabels==ci);
    Dc3       =  D3(:,Dlabels==ci);
    error(ci) = (norm(y-Dc1*a1-Dc2*a2-Dc3*a3,2)^2);
end
 
index      =  find(error==min(error));
id         =  index(1);
