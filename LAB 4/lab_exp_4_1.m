clear all;
close all;
f = imread('cameraman.tif');

f1=pad1(f,1);
f2=pad2(f,1);

row=size(f1,1);
col=size(f1,2);

inn1 = imnoise(f1,'salt & pepper',0.02);
inn2 = imnoise(f2,'salt & pepper',0.02);

for i=2:1:row-1
    for j=2:1:col-1
        g1(i-1,j-1) = min(min(inn2(i-1:i+1 ,j-1:j+1)));
        g2(i-1,j-1) = max(max(inn1(i-1:i+1 ,j-1:j+1)));
        med = inn2(i-1:i+1 ,j-1:j+1);
        g3(i-1,j-1) = median(med(:));    
    end
end


subplot(2,3,1),imshow(f1)
title("input image")
subplot(2,3,2),imshow(inn1)
title("noise image")

subplot(2,3,3),imshow(g1)
h1=psnrf(f,g1);
r1=ssim(f,g1);
title({['minimum image PSNR = ', num2str(h1)]; ['SSIM = ', num2str(r1)]})
%PSNR for the minimum
disp(h1);
%SSIM for the minimum
disp(r1);


subplot(2,3,4),imshow(g2)
h2=psnrf(f,g2);
r2=ssim(f,g2);
title({['maximum image PSNR = ', num2str(h2)]; ['SSIM = ', num2str(r2)]})
%PSNR for the maximum
disp(h2);
%SSIM for the maximum
disp(r2);

subplot(2,3,5),imshow(g3)
h3=psnrf(f,g3);
r3=ssim(f,g3);
title({['median image PSNR = ', num2str(h3)]; ['SSIM = ', num2str(r3)]})
%PSNR for the median
disp(h3);
%SSIM for the median
disp(r3);



function pad = pad1(f1,k)
    row=size(f1,1);
    col=size(f1,2);
    f1=cat(2,f1,zeros(row,k));
    f1=cat(2,zeros(row,k),f1);
    f1=cat(1,zeros(k,col+(2*k)),f1);
    f1=cat(1,f1,zeros(k,col+(2*k)));
    pad=f1;
end

function pad = pad2(f1,k)
    row=size(f1,1);
    col=size(f1,2);
    f1=cat(2,f1,ones(row,k)*255);
    f1=cat(2,ones(row,k)*255,f1);
    f1=cat(1,ones(k,col+(2*k))*255,f1);
    f1=cat(1,f1,ones(k,col+(2*k))*255);
    pad=f1;
end

function psnr =psnrf(h,g)
    row=size(h,1);
    col=size(h,2);
    MSE= sum(sum((double(h) - double(g)).^2))/(row*col);
    psnr = 10 *log10(255^2/MSE);
end
