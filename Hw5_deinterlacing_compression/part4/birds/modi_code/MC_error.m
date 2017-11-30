function errorfunc=MC_error(prev_img,this_img,block_size,win_shape)
[M,N] = size(prev_img);
block_move_m = zeros(size(this_pic)/block_size,'int8');
block_move_n = zeros(size(this_pic)/block_size,'int8');

for m = 1:block_size:H
    for n = 1:block_size:W
        [dm, dn, err,enp] = block_matching(this_pic,next_pic,m,n,block_size,10);
        x = (m-1)/block_size + 1;
        y = (n-1)/block_size + 1;
        block_move_m(x,y) = dm;
        block_move_n(x,y) = dn;
    end
end
errorfunc = zeros(M,N);
for u = N+win_shape+1:M-N-win_shape
    for v = N+win_shape+1:N-N-win_shape
        errorfunc(u,v) = double(this_img(u,v)) - double(prev_img(u-block_move_m(u,v),v-block_move_m(u,v)));
    end
end
end

