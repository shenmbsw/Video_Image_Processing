function errorfunc=MC_Prediction(img1,img2,bs,win)
%%
%%input 
% img1: previous frame
% img2: current frame
% bs: block size
% win: maxium search window range
[M,N] = size(img1);
[mvr,mvc] = blockMatching(img1,img2,bs,win);
errorfunc = zeros(M,N);
for u = bs+win+1:M-bs-win
    for v = bs+win+1:N-bs-win
        errorfunc(u,v) = double(img2(u,v))-double(img1(u-mvr(u,v),v-mvc(u,v)));%compute prediction error
    end
end
end


