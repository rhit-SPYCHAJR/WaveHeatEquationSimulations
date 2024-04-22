% close all hidden                                           
q = 0.11;

intTemp = 60;
dirich = 60;

numXpix = 500;
numYpix = 2*numXpix;
perInt = 1-3*(1/(numXpix));
figure(1)
[m, u] = delTri_v1(numXpix,perInt,intTemp);

deltaX = 1/numXpix;
deltaY = 2/numYpix;
deltaT = 0.99*((deltaX^2*deltaY^2)/(2*q*(deltaX^2+deltaY^2)));

numSlic = round(2/deltaT);
numSlicToSave = 100;

w = ovenC(m,u,deltaX,deltaY,deltaT,q,2,numSlicToSave,dirich);
lim = [50 60];
figure(2)
subplot(1,4,1)
mesh(w(:,:,1))
title("t=0")
zlim(lim)
subplot(1,4,2)
mesh(w(:,:,round(numSlicToSave*(1/3))))
zlim(lim)
title("t=0.66")
subplot(1,4,3)
mesh(w(:,:,round(numSlicToSave*(2/3))))
zlim(lim)
title("t=1.33")
subplot(1,4,4)
mesh(w(:,:,end))
title("t=2")
zlim(lim)

figure(3)
filename = 'heatTest.gif';
wsize = size(w,3);
for i=1:size(w,3)
    Z = w(:,:,i);
    Z = squeeze(Z);
%     handle_surf.ZData = Z;
    mesh(Z);
    zlim([50 60])
    drawnow;
    frame = getframe(gcf);
    im = frame2im(frame);
    [A,map] = rgb2ind(im,256);
    if i==1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.01);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.01);
    end
end

function W = oven(m, u,deltaX, deltaY, deltaT, q, maxTime, numSlicToSave, dirich)
    W = zeros(size(m,1), size(m,2), numSlicToSave);
    numberInt = round(maxTime/deltaT);
    takePic = floor(numberInt/numSlicToSave);
    currPic = 1;
    for i = 0:numberInt
        w = m*0;
        for j = 1:size(m,1)
            for k = 1:size(m,2)
                if m(j,k) == 1
%                     w(j,k) = (u(j-1,k) + u(j+1,k) + u(j,k-1) + u(j,k+1)) / 4;
                    w(j,k) = u(j,k)+((q*deltaT)/(deltaX^2))*(u(j+1,k)-2*u(j,k)+u(j-1,k)) + ((q*deltaT)/(deltaY^2))*(u(j,k+1)-2*u(j,k)+u(j,k-1));
                elseif m(j,k) == 2
                    w(j,k) = u(j,k)-(1*deltaT);
                elseif m(j,k) == 3
                    w(j,k) = dirich;
                else
                    w(j,k) = 0;
                end
            end
        end
        u = w;
        if mod(i,takePic) == 0
           W(:,:,currPic) = w(:,:);
           currPic = currPic + 1;
        end
        i*deltaT;
    end
end
