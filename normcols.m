function matout=normcols(matin)
l2norms = sqrt(sum(matin.*matin,1)+eps);%����ÿ����ӱ��1��
matout = matin./repmat(l2norms,size(matin,1),1);%�ظ����ݼ������Σ�ÿ����12norms