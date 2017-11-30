frame_container = zeros(M,N,10);
predict_error_1 =zeros(M,N,10); 
predict_error_2 =zeros(M,N,10); 
predict_error_3 =zeros(M,N,10); 
block_size = 16;
win1=1;
win2=5;
win3=10;

for i = 1:10
    filename = strcat('birds_prog/birds_prog_',int2str(i),'.tif');
    gray_frame = rgb2gray(imread(filename));
    frame_container(:,:,i) = gray_frame(1:m-8,:);
    if i>1
        predict_error_1(:,:,i) = MC_Prediction(frame_container(:,:,i-1),frame_container(:,:,i),block_size,win1);
        predict_error_2(:,:,i) = MC_Prediction(frame_container(:,:,i-1),frame_container(:,:,i),block_size,win2);
        predict_error_3(:,:,i) = MC_Prediction(frame_container(:,:,i-1),frame_container(:,:,i),block_size,win3);
    end
end
entropy1 = entropy(uint8(predict_error_1(:,:,2:10)));
entropy2 = entropy(uint8(predict_error_2(:,:,2:10)));
entropy3 = entropy(uint8(predict_error_3(:,:,2:10)));

subplot(3,2,1);
imshow(uint8(predict_error_1(:,:,2)+128));
title('MC prediction error for N = 16,Dmax = 1')
subplot(3,2,2);
imhist(uint8(predict_error_1(:,:,2)+128));
title('entropy 3.2143');
subplot(3,2,3);
imshow(uint8(predict_error_2(:,:,2)+128));
title('MC prediction error N = 16,Dmax = 5')
subplot(3,2,4);
imhist(uint8(predict_error_2(:,:,2)+128));
title('entropy 3.3963');
subplot(3,2,5);
imshow(uint8(predict_error_3(:,:,2)+128));
title('MC prediction error N = 16,Dmax = 10')
subplot(3,2,6);
imhist(uint8(predict_error_3(:,:,2)+128));
title('entropy 3.6211');





