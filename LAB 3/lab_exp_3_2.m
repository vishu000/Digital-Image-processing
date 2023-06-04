clear all;
close all;
f1 = imread('cameraman.tif');
figure,imshow(f1);
title("input image")
row=size(f1,1);
col=size(f1,2);

c=255/(log2(1+255));

for i=1:1:row
    for j=1:1:col  
        g(i,j) = uint8(c*log2(double(1+f1(i,j))));
    end
end

figure,imshow(g);
title("Output image")
imwrite(g,'lab_exp_3_2_outp.jpg');
figure,plot(f1(:),g(:), '*');
title("2D graph")
