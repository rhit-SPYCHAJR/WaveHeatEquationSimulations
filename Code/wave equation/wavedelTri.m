function [m, u] = wavedelTri(numXpix,perInt,p)
% Creates matrix to encode what type of points are on the surface of an
% a sqaure with a hemisphere on the top and bottom
close all hidden

Xin = zeros(51,2);
for i = 0:50
    theta = i*(pi/24);
    vec = [cos(theta), sin(theta)];
    Xin(i+1,:) = (1/(norm(vec,p))*vec*perInt)/2;
end

XDir = zeros(51,2);
for i = 0:50
    theta = i*(pi/24);
    vec = [cos(theta), sin(theta)];
    XDir(i+1,:) = (1/(norm(vec,p))*vec)/2;
end

dtin = delaunayTriangulation(Xin);
dtDir = delaunayTriangulation(XDir);

hold on
% figure(1)
% triplot(dtin,'g')
% figure(2)
% triplot(dtDir,'b')
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
q = q/numXpix - 0.5;

hold on
% figure(4)
% plot(q(:,1),q(:,2),'.r'); 
hold off

tiIn = pointLocation(dtin,q);
tiDir = pointLocation(dtDir,q);

m = zeros(numXpix,numXpix);
m(find(~isnan(tiDir))) = 2;
m(find(~isnan(tiIn))) = 1;

u = zeros(numXpix,numXpix);
for i = 1:size(m,1)
    for j = 1:size(m,2)
        if m(i,j) > 0
            u(i,j) = (((i/numXpix)-0.5)^2+((j/numXpix)-0.5)^2)/10;
        end
    end
end

% mesh(m)
end
