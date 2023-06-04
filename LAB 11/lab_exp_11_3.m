clear all;
close all;
f = imread("Images\3096.jpg");
f1 = rgb2gray(f);
f2 = im2double(f1);
subplot(1,3,1),imshow(f);
title("input image")
gt = imread("Groundtruth\3096.png");
subplot(1,3,2),imshow(gt);
title("ground truth image")

w1=ones(7,7);
for i=1:1:7
    for j=1:1:7
        x=i-4;
        y=j-4;
        s=1;
        w1(i,j) = (1/((sqrt(2*pi)*s^2)))*exp(-(x^2+y^2)/(2*s^2));
    end
end
w1 = w1./sum(w1(:));

p1=padd(f2,size(ones(7), 1));
r1 = conv(p1,w1);
l1 = [1 1 1;1 -8 1;1 1 1];
p2=padd(r1,size(ones(3), 1));
r= conv(p2,l1);
out = marr(r);

for i=1:1:size(out,1)
    for j=1:1:size(out,2)
        t=18/255;
        if out(i,j) > t
            out(i,j) = 1;
        end
        if out(i,j) <= t
            out(i,j) = 0;
        end
    end
end

subplot(1,3,3),imshow(out);
title("output image")

function ma = marr(r)
    r=padd(r,size(ones(3), 1));
    row=size(r,1);
    col=size(r,2);
    out = zeros(row-2,col-2);
    for i =2:1:row-1
        for j=2:1:col-1
            if r(i,j+1)*r(i,j-1) < 0
                out(i-1,j-1) = r(i,j);
            elseif r(i-1,j)*r(i+1,j) < 0
                out(i-1,j-1) = r(i,j);
            elseif r(i+1,j-1)*r(i-1,j+1) < 0
                out(i-1,j-1) = r(i,j);
             elseif r(i-1,j-1)*r(i+1,j) < 0
                out(i-1,j-1) = r(i,j);
            end
        end
    end
    ma =out;
end

%out = out > 18/255;
function co = conv(f,k)
   t = size(k, 1);
   row=size(f,1);
   col=size(f,2);
   for i =1:1:row-(t-1)
    for j=1:1:col-(t-1)
        g(i,j)=  sum(sum(f(i:i+(t-1),j:j+(t-1)).*k));
    end
   end
   co=g;
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