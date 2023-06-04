clear all;
close all;
f = imread('cameraman.tif');
figure,imshow(f)
title("input image")
row=size(f,1);
col=size(f,2);

g =zeros([1,256]);

for i=1:1:row
    for j=1:1:col  
        g(f(i,j)) = g(f(i,j))+1;
    end
end

for i=1:1:row
    p(i) = g(i)/(row*col);
end

con=0;
for i=1:1:row
    con =con + p(i);
    t(i) = 255*(con);
    t(i) =round(t(i));
end

for i=1:1:row
    for j=1:1:col  
        out(i,j) = uint8(t(f(i,j)+1));
    end
end

figure,imshow(out)
title("output image")

figure,bar(out);
title("bar graph")

y= histeq(f);
figure,bar(y);
title("inbuilt bar graph")







