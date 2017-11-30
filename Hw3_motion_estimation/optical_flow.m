close all

Ik = imread('Fall_trees_0.tif');
Il = imread('Fall_trees_2.tif');


[H,W] = size(Ik);
[Ix,Iy,It] = gradiance(Ik,Il);

u = zeros([H,W]);
v = zeros([H,W]);
u0=u;
v0=v;
u_bar = zeros([H,W]);
v_bar = zeros([H,W]);
u_ture = repmat(2,72,88);
v_ture = repmat(2,72,88);

lambda = 50;
max_iter = 200;
x_axis = 1:max_iter;
cost = zeros(max_iter,1);
MSE =  zeros(max_iter,1);

for iter = 1:max_iter
    if (mod(iter,4)==1)
        for i = 1:H
            for j = 1:W
                nei = [i,j; i-1,j; i,j-1;   i+1,j; i,j+1];
                k = nei(:,1)<=0  |  nei(:,2)<=0 | nei(:,1)>144 | nei(:,2)>176;
                nei(k,:) = [];
                u_bar(i,j) = mean(mean(u(nei)));
                v_bar(i,j) = mean(mean(u(nei)));
                u(i,j) = u_bar(i,j) -  Ix(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2); 
                v(i,j) = v_bar(i,j) -  Iy(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2);
            end
        end
    elseif (mod(iter,4)==2)
        for i = H:-1:1
            for j = W:-1:1
                nei = [i,j; i-1,j; i,j-1;   i+1,j; i,j+1];
                k = nei(:,1)<=0  |  nei(:,2)<=0 | nei(:,1)>144 | nei(:,2)>176;
                nei(k,:) = [];
                u_bar(i,j) = mean(mean(u(nei)));
                v_bar(i,j) = mean(mean(u(nei)));
                u(i,j) = u_bar(i,j) -  Ix(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2); 
                v(i,j) = v_bar(i,j) -  Iy(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2);
            end
        end
    elseif (mod(iter,4)==3)
        for i = 1:H
            for j = W:-1:1
                nei = [i,j; i-1,j; i,j-1;   i+1,j; i,j+1];
                k = nei(:,1)<=0  |  nei(:,2)<=0 | nei(:,1)>144 | nei(:,2)>176;
                nei(k,:) = [];
                u_bar(i,j) = mean(mean(u(nei)));
                v_bar(i,j) = mean(mean(u(nei)));
                u(i,j) = u_bar(i,j) -  Ix(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2); 
                v(i,j) = v_bar(i,j) -  Iy(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2);
            end
        end
    else
        for i = H:-1:1
            for j = 1:W
                nei = [i,j; i-1,j; i,j-1;   i+1,j; i,j+1];
                k = nei(:,1)<=0  |  nei(:,2)<=0 | nei(:,1)>144 | nei(:,2)>176;
                nei(k,:) = [];
                u_bar(i,j) = mean(mean(u(nei)));
                v_bar(i,j) = mean(mean(u(nei)));
                u(i,j) = u_bar(i,j) -  Ix(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2); 
                v(i,j) = v_bar(i,j) -  Iy(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2);
            end
        end    
    end
    cost(iter) = loss_function(Ix,Iy,It,u,v,lambda);
    MSE(iter) = sum(sum((u-u_ture).^2 + (v-v_ture).^2));
    
    if (iter==10)
        u10 = u;
        v10 = v;
    elseif(iter==50)
        u50 = u;
        v50 = v;
    end
end

E0 = double(Il) - double(Ik);
Ik_bar = interpolation(Ik,u,v);
En = double(Il) - Ik_bar;


figure
subplot(2,2,1)
imshow(uint8(E0+128))
title('Error at iter 0')
subplot(2,2,2)
imshow(uint8(En+128))
title('Error at iter n')
subplot(2,2,3)
plot(x_axis,cost)
title('object function cost')
xlabel('iter')
ylabel('object cost')
subplot(2,2,4)
plot(x_axis,MSE)
title('Min square error')
xlabel('iter')
ylabel('MSE')
suptitle('Fall trees 0 to 2')


figure
[X,Y] = meshgrid(1:W,H:-1:1);
subplot(2,2,1)
quiver(X,Y,u0,v0);
title('quiver at i0')
xlim([1,W+1])
ylim([1,H+1])
subplot(2,2,2)
quiver(X,Y,u10,v10);
title('quiver at i10')
xlim([1,W+1])
ylim([1,H+1])
subplot(2,2,3)
quiver(X,Y,u50,v50);
title('quiver at i50')
xlim([1,W+1])
ylim([1,H+1])
subplot(2,2,4)
quiver(X,Y,u,v);
title('quiver at i200')
xlim([1,W+1])
ylim([1,H+1])
suptitle('Fall trees 0 to 2')
