clear all;
close all;
f = imread('cameraman.tif');
subplot(1,2,1),imshow(f);
title("input image")
row=size(f,1);
col=size(f,2);

%Histogram
g =zeros([1,256]);
for i=1:1:row
    for j=1:1:col
        g(f(i,j)) = g(f(i,j))+1;
    end
end

% Global Thresholding.
for i=1:1:row
    for j=1:1:col  
        t=94;
        if f(i,j) > t
            o1(i,j) = 255;
        end
        if f(i,j) <= t
            o1(i,j) = 0;
        end
    end
end

% Multiple Thresholding.
for i=1:1:row
    for j=1:1:col  
        t1= 100;
        t2= 190;
        if f(i,j) > t2
            o2(i,j) = 255;
        elseif t1 < f(i,j)  && f(i,j) < t2
            o2(i,j) = 100;
        else 
            o2(i,j) = 0;
        end
    end
end

% Thresholding using Mean.
s=sum(sum(f));
t3 = s/(row*col);
for i=1:1:row
    for j=1:1:col  
        if f(i,j) > t3
            o3(i,j) = 255;
        end
        if f(i,j) <= t3
            o3(i,j) = 0;
        end
    end
end

% Thresholding using Median
t4 = median(f(:));
for i=1:1:row
    for j=1:1:col  
        if f(i,j) > t4
            o4(i,j) = 255;
        end
        if f(i,j) <= t4
            o4(i,j) = 0;
        end
    end
end

% Thresholding using average of maximum and minimum pixels
m1 = double(max(f(:)));
m2 = double(min(f(:)));
t5 = round((m1 + m2)/2);
for i=1:1:row
    for j=1:1:col  
        if f(i,j) > t5
            o5(i,j) = 255;
        end
        if f(i,j) <= t5
            o5(i,j) = 0;
        end
    end
end

subplot(2,3,1),imshow(f);
title("input image")
subplot(2,3,2),imshow(o1);
title("Global Thresholding image")
subplot(2,3,3),imshow(o2,[]);
title("Multiple Thresholding image")
subplot(2,3,4),imshow(o3);
title("Thresholding using Mean image")
subplot(2,3,5),imshow(o4);
title("Thresholding using Median image")
subplot(2,3,6),imshow(o5);
title("Thresholding using average of maximum and minimum pixels image")
figure,bar(g);