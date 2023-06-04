clear all;
close all;
f = imread('cameraman.tif');
subplot(1,3,1),imshow(f);
title("input image")
f = im2double(f);
row=size(f,1);
col=size(f,2);
n=8;
m=8;

%using Inbuilt function
for i=1:8:row
    for j=1:8:col
        z1(i:i+n-1,j:j+n-1) = fft2(f(i:i+n-1,j:j+n-1));
    end
end

for i=1:8:row
    for j=1:8:col
        z2(i:i+n-1,j:j+n-1) = ifft2(z1(i:i+n-1,j:j+n-1));
    end
end

subplot(1,3,2),imshow(z2,[]);
title("inbuilt image")

dft_f=dft2d(f);
idft_f=abs(idft2d(dft_f));
subplot(1,3,3),imshow(idft_f,[]);
title("output image")

%DFT
function id = dft2d(f)
    row=size(f,1);
    col=size(f,2);
    n=8;
    m=8;
    u=sqrt(-1);
    for i=1:8:row
        for j=1:8:col
            for k=0:1:n-1
                for l=0:1:m-1
                    p=0;
                    for x=0:1:n-1
                        for y=0:1:m-1
                            p = p + f(i+x,j+y)*exp(((-u*2*pi)/m)*x*k)*exp(((-u*2*pi)/n)*y*l);
                        end
                    end
                    dft_f(i+k,j+l) = p;
                end
            end
        end
    end
    id=dft_f;
end

%IDFT
function id2 = idft2d(g)
    row=size(g,1);
    col=size(g,2);
    n=8;
    m=8;
    u=sqrt(-1);
    const = 1/(m*n);
    for i=1:8:row
        for j=1:8:col
            for x=0:1:n-1
                for y=0:1:m-1
                    q=0;
                    for k=0:1:n-1
                        for l=0:1:m-1
                            q = q + g(i+k,j+l)*exp(((u*2*pi)/m)*x*k)*exp(((u*2*pi)/n)*y*l);
                        end
                    end
                    idft_f(i+x,j+y) = const * abs(q);
                end
            end
        end
    end
    id2=idft_f;
end