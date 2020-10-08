function [output]=time(img)
X=[5 10 15 20 25];
W=[1 2 3 4 5];
x_sz=size(X);
x_sz=x_sz(1,2)
w_sz=size(W);
w_sz=w_sz(1,2)
T1=zeros(size(W));
T2=zeros(size(W));
T3=zeros(size(W));
img=double(img);
    for i=1:w_sz
        nimg=img+20*randn(size(img));
        tic
        D2=NLmeansfilter_euc(nimg,W(i),1,20);
        nlm_time =toc
        fprintf('D2 calculated with time=%d\n',nlm_time);
        tic
        D3=NLmeansfilter_fast(nimg,1,W(i),20);
        fast_nlm_time=toc
        fprintf('D3 calculated with time=%d\n',fast_nlm_time);
        T2(1,i)=nlm_time
        T3(1,i)=fast_nlm_time
    end
    title('Time taken(seconds) vs search window');
    hold on
    plot(W,T2,'-x','DisplayName','Euclidean');
    plot(W,T3,'-o','DisplayName','Fast');
    xlabel('search window');
    ylabel('time taken(seconds)');
    hold off
    legend();
    output=[W,T1,T2,T3];
end