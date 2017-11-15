clear

this_pic = imread('coastguard_90.tif');
next_pic = imread('coastguard_95.tif');
[H,W] = size(this_pic);
block_size = 32;

block_move_m = zeros(size(this_pic)/block_size,'int8');
block_move_n = zeros(size(this_pic)/block_size,'int8');

compan = zeros(size(this_pic),'uint8');

overall_err = 0;
overall_enp = 0;

tic
for m = 1:block_size:H
    for n = 1:block_size:W
        [dm, dn, err,enp] = block_matching(this_pic,next_pic,m,n,block_size,10);
        x = (m-1)/block_size + 1;
        y = (n-1)/block_size + 1;
        block_move_m(x,y) = dm;
        block_move_n(x,y) = dn;
        
        compan(m:m+block_size-1,n:n+block_size-1) = 128 + this_pic(m:m+block_size-1,n:n+block_size-1) - next_pic(m+dm:m+dm+block_size-1,n+dn:n+dn+block_size-1);
        
        overall_err = overall_err + err;
        overall_enp = overall_enp + enp;
    end
end
toc

% figure
% [X,Y] = meshgrid(1:W/block_size,H/block_size:-1:1);
% quiver(X,Y,block_move_n,-block_move_m,0.4);
% title('block matching')
% 
overall_err
overall_enp
% 
% 
% imshow(compan)