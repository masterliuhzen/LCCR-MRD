function matout=normcols(matin)
l2norms = sqrt(sum(matin.*matin,1)+eps);%矩阵每列相加变成1行
matout = matin./repmat(l2norms,size(matin,1),1);%重复数据集行数次，每行是12norms