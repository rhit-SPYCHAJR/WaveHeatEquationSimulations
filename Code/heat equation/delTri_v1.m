function [m, u] = delTri_v1(numXpix,perInt,intTemp)
% Creates matrix to encode what type of points are on the surface of an
% a sqaure with a hemisphere on the top and bottom

Xin = zeros(42,2);
for i = 0:50
    theta = i*(pi/50);
    Xin(i+1,1) = 0.5+0.5*cos(theta)*perInt;
    Xin(i+1,2) = 1.5+0.5*sin(theta)*perInt;
end
for i = 50:100
    theta = i*(pi/50);
    Xin(i+2,1) = 0.5+0.5*cos(theta)*perInt;
    Xin(i+2,2) = 0.5+0.5*sin(theta)*perInt;
end

XNeum = zeros(42,2);
for i = 0:50
    theta = i*(pi/50);
    XNeum(i+1,1) = 0.5+0.5*cos(theta);
    XNeum(i+1,2) = 1.5+0.5*sin(theta);
end
for i = 50:100
    theta = i*(pi/50);
    XNeum(i+2,1) = 0.5+0.5*cos(theta);
    XNeum(i+2,2) = 0.5+0.5*sin(theta);
end

XDirch = [0 0.5; 0 1.5; 1 0.5; 1 1.5;];

dtin = delaunayTriangulation(Xin);
dtNeum = delaunayTriangulation(XNeum);
dtDirch = delaunayTriangulation(XDirch);

hold on
% figure(1)
triplot(dtin,'g')
% figure(2)
triplot(dtNeum,'b')
% figure(3)
triplot(dtDirch,'m')
hold off

q = zeros(numXpix*(2*numXpix),2);
ind = 1;
for x = 0:numXpix-1
    for y = 1:numXpix*2
        q(ind,1) = x + 0.5;
        q(ind,2) = y - 0.5;
        ind = ind + 1;
    end
end
q = q/numXpix;

hold on
% figure(4)
plot(q(:,1),q(:,2),'.r'); 
hold off

tiIn = pointLocation(dtin,q);
tiNeum = pointLocation(dtNeum,q);
tiDirch = pointLocation(dtDirch,q);

m = zeros(2*numXpix,numXpix);
m(find(~isnan(tiNeum))) = 2;
m(find(~isnan(tiDirch))) = 3;
m(find(~isnan(tiIn))) = 1;

u = zeros(2*numXpix,numXpix);
u(find(~isnan(tiNeum))) = intTemp;

% mesh(m)
end
