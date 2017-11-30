filename = strcat('birds_prog/birds_prog_','1','.tif');
frame1 = rgb2gray(imread(filename));
[m,n,c] = size(frame1);
gray_frame = zeros(m,n,10);
error_a1 =zeros(m,n,10); 
error_a09 =zeros(m,n,10); 

for i = 1:10
    filename = strcat('birds_prog/birds_prog_',int2str(i),'.tif');
    gray_frame(:,:,i) = rgb2gray(imread(filename));
    if i>1
        error_a1(:,:,i) = uint8((gray_frame(:,:,i)-gray_frame(:,:,i-1))+128);
        error_a09(:,:,i) = uint8(gray_frame(:,:,i)-round(0.9.*gray_frame(:,:,i-1))+128);
    end
end

entropy_original = entropy(uint8(gray_frame(:,:,2:10)));
entropy_09 = entropy(uint8(error_a09(:,:,2:10)));
entropy_1 = entropy(uint8(error_a1(:,:,2:10)));
subplot(3,2,1);
imshow(uint8(gray_frame(:,:,2)));
title('frame 2');
subplot(3,2,2);
imhist(uint8(gray_frame(:,:,2)));
title('entropy: 7.6371');
subplot(3,2,3);
imshow(uint8(error_a09(:,:,2)));
title('temporal prediction error for alpha=0.9');
subplot(3,2,4);
imhist(uint8(error_a09(:,:,2)));
title('entropy: 5.3513');
subplot(3,2,5);
imshow(uint8(error_a1(:,:,2)));
title('temporal prediction error for alpha 1.0');
subplot(3,2,6);
imhist(uint8(error_a1(:,:,2)));
title('entropy: 4.7471');





