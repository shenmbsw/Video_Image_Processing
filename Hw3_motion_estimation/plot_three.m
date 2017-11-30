clear
load('coast.mat')
load('container.mat')
load('missa.mat')

figure
subplot(3,2,1)
imshow(uint8(E0_m+128))
title('E0 for missa')
subplot(3,2,2)
imshow(uint8(En_m+128))
title('En for missa')
subplot(3,2,3)
imshow(uint8(En_con+128))
title('E0 for container')
subplot(3,2,4)
imshow(uint8(En_con+128))
title('En for container')
subplot(3,2,5)
imshow(uint8(En_coas+128))
title('E0 for coast')
subplot(3,2,6)
imshow(uint8(En_coas+128))
title('En for coast')

u = ucon;
v = vcon;

figure
[H,W] = size(u);
i = 2:2:H;
j = 2:2:W;
u(i,:) = [];
u(:,j) = [];
v(i,:) = [];
v(:,j) = [];
[X,Y] = meshgrid(1:2:W,H:-2:1);
quiver(X,Y,u,v,0)
xlim([1,W+1])
ylim([1,H+1])
