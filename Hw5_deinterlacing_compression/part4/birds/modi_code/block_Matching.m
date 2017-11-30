function [dm, dn, error,entropy_loss] = block_Matching(this_pic,next_pic,m,n, S, D)
    this_block = this_pic(m:m+S-1,n:n+S-1);
    [H,W] = size(next_pic);
    idx = 1;
    err = [];
    mm = [];
    nn = [];
    for i = -D:D
        for j = -D:D
            m2 = m+i;
            n2 = n+j;
            if (m2<1 || m2>H-S || n2<1 || n2 >W-S)
                continue
            else   
                cmp_block = next_pic(m2:m2+S-1,n2:n2+S-1);
                err(idx) = sum(sum(abs(this_block - cmp_block)));
                mm(idx) = m2;
                nn(idx) = n2;
                idx = idx + 1;
            end
        end
    end
    smallest = find(err == min(err));
    smallest = smallest(1);
    dm = mm(smallest) - m;
    dn = nn(smallest) - n;
    error = err(smallest);
    
    result_block = next_pic(m+dm:m+dm+S-1,n+dn:n+dn+S-1);
    error_fig = 128 + this_block - result_block;    
    entropy_loss = entropy(error_fig);
    
end