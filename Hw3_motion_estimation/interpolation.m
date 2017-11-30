function [ newpic ] = interpolation( pic,u,v )
pic = double(pic);
[H,W] = size(pic);
newpic = zeros(H,W);

for i = 1:H-1
    for j = 1:W-1
        newpic(i,j) = (1+u(i,j))*(1+v(i,j))*pic(i,j);
        newpic(i,j) = newpic(i,j) - u(i,j)*(1+v(i,j))*pic(i+1,j);
        newpic(i,j) = newpic(i,j) - (1+u(i,j))*v(i,j)*pic(i,j+1);
        newpic(i,j) = newpic(i,j) + u(i,j)*v(i,j)*pic(i+1,j+1);
    end
end