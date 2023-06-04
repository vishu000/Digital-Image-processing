clear all;
close all;
f1 = imread('dark_pollen.tif');
figure,imshow(f1);
title("input image")
row=size(f1,1);
col=size(f1,2);

g =zeros([1,256]);

for i=1:1:row
    for j=1:1:col  
        g(f1(i,j)) = g(f1(i,j))+1;
    end
end

figure,bar(g);
title("Output graph")
