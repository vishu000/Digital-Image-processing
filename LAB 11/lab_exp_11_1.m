clear all;
close all;
f = imread("Images\113044.jpg");
f1 = rgb2gray(f);
f2 = im2double(f1);
subplot(1,3,1),imshow(f);
title("input image")

wx1 = [-1 0 1;-2 0 2;-1 2 1];
wy1 = [1 2 1;0 0 0;-1 -2 -1];
wx2 = [-1 -2 1;0 0 0;1 2 1];
wy2 = [-1 0 1;-2 0 2;-1 0 1];

p=padd(f2,size(ones(3), 1));
rx1 = conv(p,wx1);
ry1 = conv(p,wy1);
r1 = abs(rx1) + abs(ry1);
subplot(1,3,2),imshow(r1,[]);
title("output1 image")
rx2 = conv(p,wx2);
ry2 = conv(p,wy2);
r2 = abs(rx2) + abs(ry2);
subplot(1,3,3),imshow(r2,[]);
title("output2 image")

function c = conv(f1,w)
    x = fix(size(w, 1)/2);
    r = size(w, 1);
    for i=x+1:1:size(f1,1)-x
        for j=x+1:1:size(f1,2)-x
            wf = f1(i-x:i+x, j-x:j+x).*w;
            c(i-x,j-x) = (1/(r^2))*sum(wf(:));
        end
    end
    c =c;
end

function pa = padd(f,k)
   row=size(f,1);
   col=size(f,2);
   p = zeros(size(f)+k-1);
   for i=fix(k/2)+1:1:row+fix(k/2)
    for j=fix(k/2)+1:1:col+fix(k/2)
        p(i,j) = f(i-fix(k/2),j-fix(k/2));
    end
   end
   pa=p;
end