function [block] = get_block(pic,m,n)
    block = pic(m:m+15,n:n+15);
end