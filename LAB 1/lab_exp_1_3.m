clear all;
close all;
img1 = imread('cap.jpeg');
img2 = imread('cameraman.tif');
figure,imshow(img1);
title("1st input image")
figure,imshow(img2);
title("2nd input image")
row=size(img1,1);
col=size(img1,2);

for i=1:1:row
    for j=1:1:col
        if img1(i,j)<img2(i,j)
            g(i,j)=0;
        else
            g(i,j)=255;
        end
    end
end

figure,imshow(g);
title("Output image")
imwrite(g,'lab_exp_1_3_outp.jpg');