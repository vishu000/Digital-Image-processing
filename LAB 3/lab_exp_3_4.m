clear all;
close all;
f = imread('cameraman.tif');
f= im2double(f);
figure,imshow(f);
title("input image")
row=size(f,1);
col=size(f,2);

f= imnoise(f,'salt & pepper',0.02);
figure,imshow(f);
title("noise image")
h=f;

f1=padding(f,1);
w1=ones(3,3);
k1=conv(f1,w1);
figure,imshow(k1);
title("3x3 Output image")
imwrite(k1,'lab_exp_3_4_1_outp.jpg');
h1=psnr(h,k1);
disp(h1)
% h1 is the PSNR value of 3x3 kernal.

f2=padding(f,2);
w2=ones(5,5);
k2=conv(f2,w2);
figure,imshow(k2);
title("5x5 Output image")
imwrite(k2,'lab_exp_3_4_2_outp.jpg');
h2=psnr(h,k2);
disp(h2)
% h2 is the PSNR value of 5x5 kernal.

f3=padding(f,3);
w3=ones(7,7);
k3=conv(f3,w3);
figure,imshow(k3);
title("7x7 Output image")
imwrite(k3,'lab_exp_3_4_3_outp.jpg');
h3=psnr(h,k3);
disp(h3)
% h3 is the PSNR value of 7x7 kernal.

f4=padding(f,4);
w4=ones(9,9);
k4=conv(f4,w4);
figure,imshow(k4);
title("9x9 Output image")
imwrite(k4,'lab_exp_3_4_4_outp.jpg');
h4=psnr(h,k4);
disp(h4)
% h4 is the PSNR value of 9x9 kernal.

figure, bar([h1,h2,h3,h4]);
title("2D bar of PSNR")

function c = conv(f1,w)
    x = fix(size(w, 1)/2);
    r = size(w, 1);
    for i=x+1:1:size(f1,1)-x
        for j=x+1:1:size(f1,2)-x
            wf = f1(i-x:i+x, j-x:j+x).*w;
            c(i-x,j-x) = (1/(r^2))*sum(wf(:));
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

function psnr =psnr(h,g)
    row=size(h,1);
    col=size(h,2);
    sqr=(uint8(h) - uint8(g)).^2;
    MSE= sum(sum(sqr));
    MSE=MSE/row*col;
    psnr = 10 *(log10(255^2/MSE));
end