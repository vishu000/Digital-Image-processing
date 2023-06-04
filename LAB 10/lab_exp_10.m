clear all;
close all;
f = imread("cameraman.tif");
subplot(1,2,1),imshow(f);
title("input image")
row = size(f,1);
col = size(f,2);

%Histogram
g= zeros([1,256]);
for i=1:row
    for j=1:col
        g(f(i,j)+1)=g(f(i,j)+1)+1;
    end
end
% Normalized histogram
for i=1:256
    p(i)=g(i)/(row*col);
end

L=256;
max=0;
for k=0:1:L-1
    % Cummulative probability of class C1
    p1=cum(0,k,p);
    p2=cum(k+1,L-1,p);
    % Mean for C1
    m1=mean(0,k,p)/p1;
    m2=mean(k+1,L-1,p)/p2;

    mc1 = mean(0,L-1,p);

    vars = p1*((m1-mc1)^2)+p2*((m2-mc1))^2;
    if max<vars
        max=vars;
        thres=k;
    end
end

% Global Thresholding.
for i=1:1:row
    for j=1:1:col
        if f(i,j)>thres
            out(i,j)=255;
        else
            out(i,j)=0;
        end
    end
end
subplot(1,2,2),imshow(out);
title("Output Image");

%Cummulative probability of class C1
function cumulative= cum(a,b,p)
    sum=0;
    for i=a:1:b
        sum=sum+p(i+1);
    end
    cumulative=sum;

end

% Mean for C1
function mean =mean(a,b,p)
    sum=0;
    for i=a:1:b
        sum=sum+(i*p(i+1));
    end
    mean=sum;
end