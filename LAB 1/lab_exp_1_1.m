clear all;
close all;
t1 = 100;
t2 = 200;
im1 = imread("cap.jpeg");
row = size(im1, 1);
col  = size(im1,2);

for i=1:1:row
    for j=1:1:col
        if 0<=t1 && t1<=im1(i,j) && im1(i,j)<=t2 && t2<255
            g(i,j) = im1(i,j);
        elseif im1(i,j)<t1
            g(i,j) = t1;
        elseif im1(i,j)>t2
            g(i,j) = t2;
        end
    end
end
figure,imshow(im1)
title("input image")
figure,imshow(g)
title("Output image")
imwrite(g,'lab_exp_1_1_outp.jpg');