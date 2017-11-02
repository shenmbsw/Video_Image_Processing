close all

Ik = imread('container_1.tif');
Il = imread('container_3.tif');

[H,W] = size(Ik);
[Ix,Iy,It] = gradiance(Ik,Il);

u = zeros([H,W]);
v = zeros([H,W]);
u_bar = zeros([H,W]);
v_bar = zeros([H,W]);

lambda = 50;
max_iter = 100;

for iter = 1:max_iter
    if (mod(iter,4)==1)
        for i = 1:H
            for j = 1:W
                nei = [i,j; i-1,j; i,j-1;   i+1,j; i,j+1];
                k = nei(:,1)<=0  |  nei(:,2)<=0 | nei(:,1)>H | nei(:,2)>W;
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
                k = nei(:,1)<=0  |  nei(:,2)<=0 | nei(:,1)>H | nei(:,2)>W;
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
                k = nei(:,1)<=0  |  nei(:,2)<=0 | nei(:,1)>H | nei(:,2)>W;
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
                k = nei(:,1)<=0  |  nei(:,2)<=0 | nei(:,1)>H | nei(:,2)>W;
                nei(k,:) = [];
                u_bar(i,j) = mean(mean(u(nei)));
                v_bar(i,j) = mean(mean(u(nei)));
                u(i,j) = u_bar(i,j) -  Ix(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2); 
                v(i,j) = v_bar(i,j) -  Iy(i,j) * (Ix(i,j)*u_bar(i,j) + Iy(i,j)*v_bar(i,j) + It(i,j)) / (8*lambda + Ix(i,j).^2 +  Iy(i,j).^2);
            end
        end    
    end
end

E0_con = double(Il) - double(Ik);
Ik_bar = interpolation(Ik,u,v);
En_con = double(Il) - Ik_bar;
ucon = u;
vcon = v;

save('container','E0_con','En_con','ucon','vcon')
[X,Y] = meshgrid(1:W,H:-1:1);
quiver(X,Y,u,v);
xlim([1,W+1])
ylim([1,H+1])
