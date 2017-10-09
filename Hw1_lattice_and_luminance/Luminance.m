clear all

BL = double(imread('Boxes_left.jpg'));
BR = double(imread('Boxes_right.jpg'));

[H,W,~] = size(BL);

for i = 1:3
    sum = ones(1,H) * BL(:,:,i) * ones(W,1);
    BL_Mu(i) = sum / (H*W);
end
for i = 1:3
    sum = ones(1,H) * BR(:,:,i) * ones(W,1);
    BR_Mu(i) = sum / (H*W);
end

BR_Sig = zeros(3,1);
BL_Sig = zeros(3,1);
for i = 1:3
    for j = 1:H
        for k = 1:W
            BR_Sig(i) = BR_Sig(i) + (BR(j,k,i) - BR_Mu(i)).^2;
            BL_Sig(i) = BL_Sig(i) + (BL(j,k,i) - BL_Mu(i)).^2;
        end
    end
    BR_Sig(i) = BR_Sig(i) / (W*H);
    BL_Sig(i) = BL_Sig(i) / (W*H);
end

for i = 1:3
    alpha(i) = sqrt( BR_Sig(i) ./ BL_Sig(i));
    beta(i) = BR_Mu(i) - alpha(i) * BL_Mu(i);
end


BL_Mu
BR_Mu

BL_Sig
BR_Sig

BL_dev = sqrt(BL_Sig)
BR_dev = sqrt(BR_Sig)

alpha
beta

BL_new = zeros(H,W,3);
for i = 1:3
    BL_new(:,:,i) = alpha(i) * BL(:,:,i) + beta(i);
end

Y = uint8(ceil(BL_new));
imwrite(Y,'new_box.jpg')

