function [output]=plot_similarity(img)
X=[1 2 3 4 5];
sz=size(X);
sz=sz(1,2);
Y1=zeros(size(X));
Y2=zeros(size(X));
Y3=zeros(size(X));
img=double(img);

    for i=1:sz
        nimg=img+20*randn(size(img));
        fprintf('X(1,i)=%d\n',X(1,i));
         D3=NLmeansfilter_fast(nimg,X(1,i),5,20);
        fprintf('D3 calculated\n');
        NM=squeeze(moment_matrix2(nimg,X(1,i)));
        fprintf('moment matrix calculated\n');
        D1=NLmeansfilter_euc(nimg,5,X(1,i),20);
        fprintf('D1 calculated\n');
        D2=NLmeansfilter_hu(nimg,1,X(1,i),20,NM);
         fprintf('D2 calculated\n');
        Y1(1,i)=myPSNR(img,D1);
        Y2(1,i)=myPSNR(img,D2);
        Y3(1,i)=myPSNR(img,D3);
    end
    plot(X,Y1,'-o','DisplayName','Euclidean');
    title('Similarity window vs PSNR (cameraman , noise=20)');
    hold on
    plot(X,Y2,'-x','DisplayName','Hu');
    plot(X,Y3,'-*','DisplayName','Fast');
    hold off
    legend();
    output=[X,Y1,Y2,Y3];
end