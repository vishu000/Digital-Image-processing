clear all;
close all;
f1 = imread('low_contrast.tif');
figure,imshow(f1);
title("input image")
row=size(f1,1);
col=size(f1,2);

a=min(f1(:));
b=max(f1(:));

for i=1:1:row
    for j=1:1:col
        g(i,j) = (255/(b-a))*(f1(i,j)-a);
    end
end

figure,imshow(g);
title("Output image")
imwrite(g,'lab_exp_2_2_outp.jpg');