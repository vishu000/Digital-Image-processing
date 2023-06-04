clear all;
close all;
f = imread('cameraman.tif');
f= im2double(f);
subplot(2,2,1),imshow(f);
title("input image")
row=size(f,1);
col=size(f,2);
h=f;

f= imnoise(f,'gaussian',0.02);
subplot(2,2,2),imshow(f);
title("noise image")

f=padding(f,1);
w1=ones(3,3);

for i=1:1:3
    for j=1:1:3
        x=i-2;
        y=j-2;
        s=1;
        w1(i,j) = (1/((sqrt(2*pi)*s^2)))*exp(-(x^2+y^2)/(2*s^2));
    end
end
w1 = w1./sum(w1(:));

k=conv(f,w1);
subplot(2,2,3),imshow(k,[]);
title("Gaussian Output image")

m = imgaussfilt(f,1);
subplot(2,2,4),imshow(m);
title("inbuilt image")

function c = conv(f,w1)
    x = fix(size(w1, 1)/2);
    r = size(w1, 1);
    for i=x+1:1:size(f,1)-x
        for j=x+1:1:size(f,2)-x
            wf = f(i-x:i+x, j-x:j+x).*w1;
            c(i-x,j-x) = sum(wf(:));
        end
    end
end

function pad = padding(f1,k)
    row=size(f1,1);
    col=size(f1,2);
    f1=cat(2,f1,zeros(row,k));
    f1=cat(2,zeros(row,k),f1);
    f1=cat(1,zeros(k,col+(2*k)),f1);
    f1=cat(1,f1,zeros(k,col+(2*k)));
    pad=f1;
end