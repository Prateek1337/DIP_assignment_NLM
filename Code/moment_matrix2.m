function [output]=moment_matrix2(input,f)
farr=zeros(1,1);
farr(1,1)=f;
 [m,n]=size(input);
sz=size(farr);
sz=1;
 NM=zeros(7,m,n);
 output=zeros(sz,7,m,n);
 for l=1:sz
 f=farr(1,l);
 input2 = padarray(input,[f f],'symmetric');
 fprintf("f=%f\n",f);
 for i=1:m
 for j=1:n
         i1 = i+ f;
         j1 = j+ f;
         W= input2(i1-f:i1+f , j1-f:j1+f);
%          fprintf("%d %d\n",i,j);
         NM(:,i,j)=feature_vec(W);
         
 end
 end
  for k=1:7
     NM(k)=zscore(NM(k),0,'all');
  end
output(l,:,:,:)=NM;
 end
 end