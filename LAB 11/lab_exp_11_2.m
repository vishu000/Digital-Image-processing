clear all;
close all;
f = imread("Images\113044.jpg");
f1 = rgb2gray(f);
f2 = im2double(f1);
subplot(1,2,1),imshow(f);
title("input image")

wx = [1 1 1;0 0 0;-1 -1 -1];
wy = [-1 0 1;-1 0 1;-1 0 1];

p=padd(f2,size(ones(3), 1));
rx = conv(p,wx);
ry = conv(p,wy);
r = abs(rx) + abs(ry);
subplot(1,2,2),imshow(r,[]);
title("input image")

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