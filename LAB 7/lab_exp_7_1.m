clear all;
close all;
f = imread('cameraman.tif');
subplot(2,3,1),imshow(f);
title("input image")
%imwrite(f,'lab_exp_7_1_original_image.png');
%original_img =imfinfo("lab_exp_7_1_original_image.png").FileSize;

f = im2double(f);
row=size(f,1);
col=size(f,2);
n=8;
m=8;

b1=[1,1,1,1,1,0,0,0
    1,1,1,1,0,0,0,0
    1,1,1,0,0,0,0,0
    1,1,0,0,0,0,0,0
    1,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0];

b2=[1,1,1,1,0,0,0,0
    1,1,1,0,0,0,0,0
    1,1,0,0,0,0,0,0
    1,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0];

b3=[1,1,1,0,0,0,0,0
    1,1,0,0,0,0,0,0
    1,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0];

%using Inbuilt function
for i=1:8:row
    for j=1:8:col
        z1(i:i+n-1,j:j+n-1) = dct2(f(i:i+n-1,j:j+n-1));
    end
end

for i=1:8:row
    for j=1:8:col
        z2(i:i+n-1,j:j+n-1) = idct2(z1(i:i+n-1,j:j+n-1));
    end
end

subplot(2,3,3),imshow(z2,[]);
title("inbuilt image")

dct_f=dct2d(f);
idct_f=idct2d(dct_f);
subplot(2,3,2),imshow(idct_f,[]);
title("output image")
imwrite(idct_f,'lab_exp_7_1_output_image.png');
output_img =imfinfo("lab_exp_7_1_output_image.png").FileSize;

m1=quant(dct_f,b1);
n1=idct2d(m1);
p1=psnrf(f,n1);
subplot(2,3,4),imshow(n1,[]);
title("15 DCT coeficents")
imwrite(n1,'lab_exp_7_1_output_image_15.png');
output_img_15 =imfinfo("lab_exp_7_1_output_image_15.png").FileSize;

m2=quant(dct_f,b2);
n2=idct2d(m2);
p2=psnrf(f,n2);
subplot(2,3,5),imshow(n2,[]);
title("10 DCT coeficents")
imwrite(n2,'lab_exp_7_1_output_image_10.png');
output_img_10 =imfinfo("lab_exp_7_1_output_image_10.png").FileSize;

m3=quant(dct_f,b3);
n3=idct2d(m3);
p3=psnrf(f,n3);
subplot(2,3,6),imshow(n3,[]);
title("6 DCT coeficents")
imwrite(n3,'lab_exp_7_1_output_image_6.png');
output_img_6 =imfinfo("lab_exp_7_1_output_image_6.png").FileSize;

comp_ratioout =(output_img)/(original_img);
comp_ratio15 =(output_img_15)/(original_img);
comp_ratio10 =(output_img_10)/(original_img);
comp_ratio6 =(output_img_6)/(original_img);

p=[p1 p2 p3];
figure,bar(p);
title("PSNR for approximated images with respect to the original input image.")

r=[comp_ratioout comp_ratio15 comp_ratio10 comp_ratio6];
figure,plot(r);
title("Compression ratio for approximated images with respect to the original input image.")

%DCT
function id = dct2d(f)
    row=size(f,1);
    col=size(f,2);
    n=8;
    m=8;
    const = 2/n;
    for i=1:8:row
        for j=1:8:col
            for k=0:1:n-1
                for l=0:1:m-1
                    cu = 1;
                    cv = 1;
                    if k==0
                        cu = (1/sqrt(2));
                    end
                    if l==0
                        cv = (1/sqrt(2));
                    end
                    p=0;
                    for x=0:1:n-1
                        for y=0:1:m-1
                            p = p + f(i+x,j+y)*cos(((2*x+1)*(k)*pi)/(2*n))*cos(((2*y+1)*(l)*pi)/(2*m));
                        end
                    end
                    dct_f(i+k,j+l) = const * cu * cv * p;
                end
            end
        end
    end
    id=dct_f;
end

%IDCT
function id2 = idct2d(g)
    row=size(g,1);
    col=size(g,2);
    n=8;
    m=8;
    const = 2/n;
    for i=1:8:row
        for j=1:8:col
            for x=0:1:n-1
                for y=0:1:m-1
                    q=0;
                    for k=0:1:n-1
                        for l=0:1:m-1
                            cu = 1;
                            cv = 1;
                            if k==0
                                cu = (1/sqrt(2));
                            end
                            if l==0
                                cv = (1/sqrt(2));
                            end
                            q = q + g(i+k,j+l)*cu*cv*cos(((2*x+1)*(k)*pi)/(2*n))*cos(((2*y+1)*(l)*pi)/(2*m));
                        end
                    end
                    idct_f(i+x,j+y) = const * q;
                end
            end
        end
    end
    id2=idct_f;
end

function qua = quant(out,b)
    row=size(out,1);
    col=size(out,2);
    n=8;
    for i=1:8:row
        for j=1:8:col
            quan(i:i+n-1,j:j+n-1) = out(i:i+n-1,j:j+n-1).*b;
        end
    end
    qua = quan;
end

function psnr =psnrf(h,g)
    row=size(h,1);
    col=size(h,2);
    MSE= sum(sum((double(h) - double(g)).^2))/(row*col);
    psnr = 10 *log10(255^2/MSE);
end
