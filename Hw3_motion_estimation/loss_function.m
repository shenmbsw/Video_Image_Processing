function [ loss ] = loss_function(Ix,Iy,It,u,v,lambda)
[H,W] = size(Ix);
loss = 0;

p = (Ix.*u + Iy.*v + It);

q = sum(sum((u(1:H-1,:)-u(2:H,:)).^2));
q = q + sum(sum((v(1:H-1,:)-v(2:H,:)).^2));
q = q + sum(sum((u(:,1:W-1)-u(:,2:W)).^2));
q = q + sum(sum((v(:,1:W-1)-v(:,2:W)).^2));
loss = loss + sum(sum(p.^2)) + lambda*q;
end

