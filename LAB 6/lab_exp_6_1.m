clear all;
close all;
f = imread('moon.tif');
f=im2double(f);
subplot(1,2,1),imshow(f);
title("input image")
row=size(f,1);
col=size(f,2);
q=f;

f=padding(f,1);

w=[1,1,1;1,-8,1;1,1,1;];

k=conv(f,w);

c0=-1;
for i=1:1:row
    for j=1:1:col
         g(i,j)=f(i,j)+c0*(k(i,j));   
    end
end

subplot(1,2,2),imshow(g);
title("Output image")

function c = conv(f,w)
    x = fix(size(w, 1)/2);
    r = size(w, 1);
    for i=x+1:1:size(f,1)-x
        for j=x+1:1:size(f,2)-x
            wf = f(i-x:i+x, j-x:j+x).*w;
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