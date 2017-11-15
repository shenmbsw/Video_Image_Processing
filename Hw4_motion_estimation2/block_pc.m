function [dm, dn, error,entropy_loss] = block_pc( this_pic,next_pic,m, n, S,mode)

    [H,W] = size(next_pic);
    this_block = this_pic(m:m+S-1,n:n+S-1);
    next_block = next_pic(m:m+S-1,n:n+S-1);

    F = phase_correlation(this_block,next_block);

    sortedF = sort(F(:),1,'descend');
    d1 = sortedF(1);
    d2 = sortedF(2);
    d3 = sortedF(3);

    row = zeros(3,1);
    col = zeros(3,1);

    % find the most three biggest index
    [row(1),col(1),~] = find(F==d1);
    [row(2),col(2),~] = find(F==d2);
    [row(3),col(3),~] = find(F==d3);

    % the coordinate start from (1,1), so we do a compensation.
    row = row-1;
    col = col-1;
    row(row>S/2) = row(row>S/2) - S;
    col(col>S/2) = col(col>S/2) - S;
    
    col = -col;
    
    m2 = m+row;
    n2 = n+col;
    cond = ( (m2<1) + (m2>(H-S+1)) + (n2<1) + (n2>(W-S+1)));
    
    m2 = m2(cond==0);
    n2 = n2(cond==0);
    max_idx = numel(m2);   
    
    err = [];
    for i = 1:max_idx
        cmp_block = next_pic(m2(i):m2(i)+S-1,n2(i):n2(i)+S-1);
        err(i) = sum(sum(abs(this_block - cmp_block)));
    end
    if (max_idx == 0)
        dm = 0;
        dn = 0;
        error = 0;
    else        
        best_i = find(err == min(err));
        best_i = best_i(1);
        error = err(best_i);
        dm = m2(best_i)-m;
        dn = n2(best_i)-n;
    end
    
    result_block = next_pic(m+dm:m+dm+S-1,n+dn:n+dn+S-1);
    error_fig = 128 + this_block - result_block;    
    entropy_loss = entropy(error_fig);
    
    if (mode == 'f1')
        dm = row(1);
        dn = col(1);
    elseif (mode == 'f2')
        dm = row(2);
        dn = col(2);
    elseif (mode == 'f3')
        dm = row(3);
        dn = col(3);
    end
    

end

