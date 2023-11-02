clear all
close all
clc

load durer
newmap1 = colormap(gray(128));
newmap2 = newmap1;
newmap2(:,2) = 0;
newmap2(:,3) = 0;
newmap = [newmap1;newmap2];

width_of_X = size(X,2);
zer = zeros(24,width_of_X);
one = ones(24,width_of_X);

conc = [zer;one];
newX = repmat(conc,13,1);
newX = [newX;zer];

newX = newX.*128;
newX = newX+X;
image(newX)
axis off
axis equal
colormap(newmap)


%%



grate = zeros(200,200);
for n=1:200
    grate(n,:) = 256 * (abs(sin(2*pi*n/50)));
end
colormap(gray(256))
image(grate)
axis off;
axis equal;



grate = zeros(256,200);
for n=1:256
    grate(n,:) = n;
end
test = colormap(gray(256))
image(grate)
axis off;
axis equal;




[x,map] = imread('VisionLab','gif');
image(x);
axis off;
axis equal;
input('Press a button');
colormap(map)
input('Press a button');
colormap(hot)


[x,map] = imread('VisionLab','jpg');
image(x);
axis off;
axis equal;
input('Press a button');
colormap(map)
input('Press a button');
colormap(hot)





