clear all;
close all;
f1 = imread('cap.jpeg');
f2 = imread("cameraman.tif");
a=0.5;
figure,imshow(f1);
title("1st input image")
figure,imshow(f2);
title("2nd input image")
row=size(f1,1);
col=size(f1,2);

for i=1:1:row
    for j=1:1:col
        g(i,j) = a*f1(i,j)+(1-a)*f2(i,j);
    end
end

figure,imshow(g);
title("Output image")
imwrite(g,'lab_exp_1_2_outp.jpg');