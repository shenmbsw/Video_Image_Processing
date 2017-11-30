function [mvr,mvc] = blockMatching(a,b,bs,win)
%%
%%input 
% a: previous frame
% b: current frame
% bs: block size
% win: maxium search window range

%%output
%mvr: vertical vector field
%mvc: horizontal vector field

[m,n] = size(a);
prepad = zeros(m+2*win,n+2*win);
prepad(1+win:m+win,1+win:n+win) = a;
M = m/bs;
N = n/bs;
MVR = zeros(M,N);
MVC = zeros(M,N);
mvr = zeros(m,n);
mvc = zeros(m,n);


for i = 0:M-1
    for j = 0:N-1
        emp = zeros(win*2+1,win*2+1);
        block = b(i*bs+1:(i+1)*bs,j*bs+1:(j+1)*bs);%discretize into blocks
        searchwin = prepad(1+win+i*bs-win:win+(i+1)*bs+win,1+win+j*bs-win:win+(j+1)*bs+win);%search window define
        for k = 0:win*2
            for p = 0:win*2
              emp(k+1,p+1)= sum(sum(abs(uint8(block)-uint8(searchwin(k+1:k+bs,p+1:p+bs)))))/(bs^2);%MAE MATCHING
            end
        end
        [x,y]=find(emp == min(min(emp)));%minium mae position
        if isscalar(x)%if multiple results
         X = x;
         Y = y;
        else
            len = length(x);
            comparedist = zeros(len,1);
            
            for t = 1:len
                comparedist(t) = sqrt((x(t)-(win*2+2)/2).^2+(y(t)-(win*2+2)/2).^2);%compute the distance
            end
            [r,c] = find(comparedist == min(min(comparedist)));%find minimum distance
            if isscalar(r)%if still multiple results
                R = r;
            else
                L = length(r);
                R = randperm(L,1);%random select one
            end
            X = x(R);
            Y = y(R);
        end
        d1 = X-(win*2+2)/2;%vector to the centor
        d2 = Y-(win*2+2)/2;
        MVR(i+1,j+1) = d1;
        MVC(i+1,j+1) = d2;
        
        mvr(i*bs+1:(i+1)*bs,j*bs+1:(j+1)*bs) = ones(bs).*d1;%assign vector to image size
        mvc(i*bs+1:(i+1)*bs,j*bs+1:(j+1)*bs) = ones(bs).*d2;
    end    
end
end


