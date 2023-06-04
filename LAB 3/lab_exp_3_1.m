clear all;
close all;
f1 = imread('cameraman.tif');
figure,imshow(f1);
title("input image")
row=size(f1,1);
col=size(f1,2);

L=256;

for i=1:1:row
    for j=1:1:col
        g(i,j) = L-1-f1(i,j);
    end
end

figure,imshow(g);
title("Output image")
imwrite(g,'lab_exp_3_1_outp.jpg');