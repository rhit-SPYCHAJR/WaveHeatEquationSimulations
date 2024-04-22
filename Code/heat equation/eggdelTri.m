function [m, u] = eggdelTri(numXpix,perInt,intTemp)
% Creates matrix to encode what type of points are on the surface of an
% a sqaure with a hemisphere on the top and bottom
close all hidden

Xin = zeros(51,2);
for i = 0:50
    theta = i*(pi/24);
    vec = [cos(theta), sin(theta)];
    a=6; b=4; d=1;
    Xin(i+1,:) = [((a^2-d^2*vec(2)^2)^(1/2)+d*vec(1))*vec(1),b*vec(2)]*perInt;
end
%https://mathcurve.com/courbes2d.gb/oeuf/oeuf.shtml

Xin = (Xin+[6,4])./[14,8];

XDir = zeros(51,2);
for i = 0:50
    theta = i*(pi/24);
    vec = [cos(theta), sin(theta)];
    a=6; b=4; d=1;
    XDir(i+1,:) = [((a^2-d^2*vec(2)^2)^(1/2)+d*vec(1))*vec(1),b*vec(2)];
end

XDir = (XDir+[6,4])./[14,8];


dtin = delaunayTriangulation(Xin);
dtDir = delaunayTriangulation(XDir);

hold on
figure(1)
triplot(dtin,'g')
% figure(2)
triplot(dtDir,'b')
hold off

q = zeros(numXpix*numXpix,2);
ind = 1;
for x = 0:numXpix-1
    for y = 1:numXpix
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
tiDir = pointLocation(dtDir,q);

m = zeros(numXpix,numXpix);
m(find(~isnan(tiDir))) = 2;
m(find(~isnan(tiIn))) = 1;

u = zeros(numXpix,numXpix);
u(find(~isnan(tiDir))) = intTemp;
% for i = 1:size(m,1)
%     for j = 1:size(m,2)
%         if m(i,j) > 0
%             u(i,j) = (((i/numXpix)-0.5)^2+((j/numXpix)-0.5)^2)/10;
%         end
%     end
% end

% mesh(m)
end
