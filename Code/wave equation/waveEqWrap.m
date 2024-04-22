% close all hidden

dirich = 0.1;
p=1;

numXpix = 250;
numYpix = numXpix;
perInt = 1-3*(1/(numXpix));
figure(1)
[m, u] = wavedelTri(numXpix,perInt,p);

deltaX = 1/numXpix;
deltaY = 1/numYpix;
deltaT = 0.99*((deltaX^2*deltaY^2)/(2*(deltaX^2+deltaY^2)));

numSlic = round(2/deltaT);
numSlicToSave = 100;

w = wiggleC(m,u,u,deltaX,deltaY,deltaT,2,numSlicToSave,dirich);
figure(2)
% mesh(w(:,:,12))
% zlim([58 60])
% contourf(w)

figure(3)
filename = 'waveTest.gif';
for i=1:size(w,3)
    Z = w(:,:,i);
    Z = squeeze(Z);
%     handle_surf.ZData = Z;
    mesh(Z);
    zlim([-0.4 0.6])
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


