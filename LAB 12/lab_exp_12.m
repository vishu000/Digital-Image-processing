clear all;
close all;
f = imread("Images\42049.jpg");
f2 = double(f);
figure,imshow(f);
title("input image")
row=size(f,1);
col=size(f,2);

w1=ones(7,7);
for i=1:1:7
    for j=1:1:7
        x=i-4;
        y=j-4;
        s=1;
        w1(i,j) = (1/((sqrt(2*pi)*s^2)))*exp(-(x^2+y^2)/(2*s^2));
    end
end

p1=padd(f2,size(ones(7), 1));
r1 = conv(p1,w1);

wx = [-1 -2 -1;0 0 0;1 2 1];
wy = [-1 0 1;-2 0 2;-1 0 1];
px=padd(r1,size(ones(3), 1));
ix= conv(px,wx);
iy= conv(px,wy);
ga = gradiant(ix,iy);

e_mag = abs(ix) + abs(iy);
e_nms = zeros(row,col);
e_bin = zeros(row,col);
t = 40;
th = 200;
for u =2:1:row-1
    for v=2:1:col-1
        dx = ix(u,v);
        dy = iy(u,v);
        s0 = oriantation(dx,dy);
        if localmax(e_mag,u,v,s0,t)
            e_nms(u,v) = e_mag(u,v);
        end
    end
end
for u =2:1:row-1
    for v=2:1:col-1
        if (e_nms(u,v) >= th) && (e_bin(u,v) == 0)
            [e_nms,e_bin] = threshold(e_nms,e_bin,u,v,t);
        end
    end
end
figure,imshow(e_bin);

function [out] = oriantation(x,y)
    dx = cos(pi/8)*x - cos(pi/8)*y;
    dy = sin(pi/8)*x + cos(pi/8)*y;
    if dy < 0
        dx = -dx;
        dy = -dy;
    end
    if dx >= 0 && dx >= dy 
        out = 0;
    elseif  dx >= 0 && dx < dy
        out = 1;
    elseif  dx < 0 && -dx < dy 
        out = 2;
    elseif dx < 0 && -dx >= dy
        out = 3;
    end
end

function [lo] = localmax(e_mag,u,v,s0,t)
    mc  = e_mag(u,v);
    if mc < t 
        lo = false;
    else 
        if s0 == 0
            ml = e_mag(u-1,v);
            mr = e_mag(u+1,v);
        elseif s0 == 1
            ml = e_mag(u-1,v-1);
            mr = e_mag(u+1,v+1);
        elseif s0 == 2
            ml = e_mag(u,v-1);
            mr = e_mag(u,v+1);
        elseif s0 == 3
            ml = e_mag(u-1,v+1);
            mr = e_mag(u+1,v-1);
        end
        lo = (ml <= mc) && (mc >= mr);
    end
end

function [p,q] = threshold(e_nms,e_bin,u0,v0,t)
    p = e_nms;
    q = e_bin;
    M = size(p,1);
    N = size(p,2);
    q(u0,v0) = 1;
    ul = max(u0-1,0);
    ur = min(u0+1,M-1);
    vt = max(v0-1,0);
    vb = min(v0+1,N-1);
    for u=ul:1:ur
        for v=vt:1:vb
            if (p(u,v) >= t) && (q(u,v) == 0)
                [p,q] = threshold(p,q,u,v,t);
            end
        end
    end
end

function gad = gradiant(x ,y)
    row=size(x,1);
    col=size(x,2);
    for i =1:1:row
        for j=1:1:col
            alfa(i,j) = atan(x(i,j)/y(i,j));
        end
    end
    gad = alfa;
end

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