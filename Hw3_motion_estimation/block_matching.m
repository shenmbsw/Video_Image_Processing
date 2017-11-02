function [dm, dn] = block_matching(block,next_pic,m,n)
    [mm,nn,pt_num] = get_idx(m,n);
    err = zeros(1,pt_num);
    for idx = 1:pt_num
        cmp_block = get_block(next_pic,mm(idx),nn(idx));
        err(idx) = sum(sum((block - cmp_block).^2));
    end
    
    smallest = find(err == min(err));
    if (numel(smallest) == 1)
        dm = mm(smallest) - m;
        dn = nn(smallest) - n;
    else
        new_mm = mm(smallest);
        new_nn = nn(smallest);
        s_x = new_mm - m;
        s_y = new_nn - n;
        dis = s_x.^2 + s_y.^2;
        [~,smallest] = min(dis);
        dm = new_mm(smallest) - m;
        dn = new_nn(smallest) - n;
    end
    
end



function [mm, nn, pt_num] = get_idx(m,n)
    r = 6;
    i = -r:r;
    j = -r:r;
    [mp,np] = meshgrid(i,j);
    mm = reshape(m + mp,[(2*r+1).^2,1]);
    nn = reshape(n + np,[(2*r+1).^2,1]);
    idx = [mm nn];
    leave = ( idx(:,1)>0 & idx(:,2)>0 & idx(:,1) <= 129 & idx(:,2)<=161);
    idx = idx(leave,:);
    mm = idx(:,1).';
    nn = idx(:,2).';
    pt_num = numel(mm);
end
function [block] = get_block(pic,m,n)
    block = pic(m:m+15,n:n+15);
end
