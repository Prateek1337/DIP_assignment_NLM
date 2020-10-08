function [output]=plot_noises(img)
X=[5 10 15 20 25 30 35];
sz=size(X);
sz=sz(1,2);
Y1=zeros(size(X));
Y2=zeros(size(X));
Y3=zeros(size(X));
Y4=zeros(size(X));
img=double(img);

    for i=1:sz
        nimg=img+X(i)*randn(size(img));
         D3=NLmeansfilter_fast(nimg,1,1,X(i));
        fprintf('D3 calculated\n');
        NM=squeeze(moment_matrix2(nimg,1));
        fprintf('moment matrix calculated\n');
        D1=NLmeansfilter_euc(nimg,1,1,X(i));
        fprintf('D1 calculated\n');
        D2=NLmeansfilter_hu(nimg,1,1,X(i),NM);
         fprintf('D2 calculated\n');
        Y1(1,i)=myPSNR(img,D1);
        Y2(1,i)=myPSNR(img,D2);
        Y3(1,i)=myPSNR(img,D3);
        Y4(1,i)=myPSNR(img,nimg);
    end
    plot(X,Y1,'-o','DisplayName','Euclidean');
    title('PSNR vs noise (Cameraman)');
    hold on
    plot(X,Y2,'-x','DisplayName','Hu');
    plot(X,Y3,'-*','DisplayName','Fast');
    plot(X,Y4,'-+','DisplayName','Noisy image');
    hold off
    legend();
    output=[X,Y1,Y2,Y3,Y4];
end