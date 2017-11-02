clear

this_pic = imread('missa_1.tif');
next_pic = imread('missa_50.tif');

block_move_m = zeros(size(this_pic),'uint8');
block_move_n = zeros(size(this_pic),'uint8');

compan = zeros(size(this_pic),'uint8');


for m = 1:16:144
    for n = 1:16:176
        block = this_pic(m:m+15,n:n+15);
        [dm, dn] = block_matching(block,next_pic,m,n);
        block_move_m(m:m+15,n:n+15) = dm;
        block_move_n(m:m+15,n:n+15) = dn;
        
        compan(m:m+15,n:n+15) = get_block(next_pic,m+dm,n+dn) - get_block(this_pic,m,n);
    end
end

[X,Y] = meshgrid(1:176,144:-1:1);
% quiver(X,Y,block_move_n,-block_move_m);
% xlim([0,177])
% ylim([0,145])

compan = compan + 128;
imshow(compan)