clear all;
close all;
f1 = imread('cameraman.tif');
figure,imshow(f1);
title("input image")
row=size(f1,1);
col=size(f1,2);

f1=im2double(f1);
c=1;
r=5;

for i=1:1:row
    for j=1:1:col  
        g(i,j) = c*(f1(i,j))^r;
    end
end

figure,imshow(g);
title("Output image")
imwrite(g,'lab_exp_3_3_outp.jpg');
figure,plot(f1(:),g(:), '*');
title("2D graph")