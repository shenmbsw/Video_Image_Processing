figure
subplot(3,3,1)
imshow(this_pic)

subplot(3,3,2)
imshow(compan)
title('CAP:0.051183, MAE:598965,ENP:562.6892')

subplot(3,3,3)
imshow(compan)
title('CAP:0.235761, MAE:492969,ENP: 565.5501')

subplot(3,3,5)
[X,Y] = meshgrid(1:W/block_size,H/block_size:-1:1);
quiver(X,Y,block_move_n,-block_move_m,0.5);

subplot(3,3,6)
[X,Y] = meshgrid(1:W/block_size,H/block_size:-1:1);
quiver(X,Y,block_move_n,-block_move_m,0.5);

subplot(3,3,7)
[X,Y] = meshgrid(1:W/block_size,H/block_size:-1:1);
quiver(X,Y,block_move_n,-block_move_m,0.5);

subplot(3,3,8)
[X,Y] = meshgrid(1:W/block_size,H/block_size:-1:1);
quiver(X,Y,block_move_n,-block_move_m,0.5);

subplot(3,3,9)
[X,Y] = meshgrid(1:W/block_size,H/block_size:-1:1);
quiver(X,Y,block_move_n,-block_move_m,0.5);