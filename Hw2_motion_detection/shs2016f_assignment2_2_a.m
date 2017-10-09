% Assume θ=1 and σM /σS =5. First, select values of σS^2 , for each of the image pairs be-
% % low, that give satisfactory fixed-threshold detection results. Then, with the selected
% value for σ^S 2 select value of T that gives satisfactory results for variable-threshold
% first-order neighborhood detection. Finally, apply the second-order neighborhood
% algorithm with the same set of parameters.
clc
clear

% Miss America
prev_f = imread('missa_1.tif');
next_f = imread('missa_50.tif');
Sig = 5;
missa_det_res = shs2016f_static_thre(prev_f,next_f,Sig);

T = 6;
first_order_Mar = shs2016f_adapt_thre( prev_f,next_f,missa_det_res,Sig,T);
second_order_Mar = shs2016f_adapt_thre( prev_f,next_f,first_order_Mar,Sig,T);

figure('Name','missa','NumberTitle','off');
subplot(2,2,1),imshow('missa_50.tif')
subplot(2,2,2),imshow(missa_det_res)
subplot(2,2,3),imshow(first_order_Mar)
subplot(2,2,4),imshow(second_order_Mar)


% Container
prev_f = imread('container_1.tif');
next_f = imread('container_30.tif');
Sig = 7;
container_det_res = shs2016f_static_thre(prev_f,next_f,Sig);

T = 10;
first_order_Mar = shs2016f_adapt_thre( prev_f,next_f,container_det_res,Sig,T);
second_order_Mar = shs2016f_adapt_thre( prev_f,next_f,first_order_Mar,Sig,T);


figure('Name','container','NumberTitle','off');
subplot(2,2,1),imshow('container_30.tif')
subplot(2,2,2),imshow(container_det_res)
subplot(2,2,3),imshow(first_order_Mar)
subplot(2,2,4),imshow(second_order_Mar)


% Coastguard
prev_f = imread('coastguard_90.tif');
next_f = imread('coastguard_95.tif');

Sig = 7;
coastguard_det_res = shs2016f_static_thre(prev_f,next_f,Sig);

T = 12;
first_order_Mar = shs2016f_adapt_thre( prev_f,next_f,coastguard_det_res,Sig,T);
second_order_Mar = shs2016f_adapt_thre( prev_f,next_f,first_order_Mar,Sig,T);

figure('Name','coastguard','NumberTitle','off');
subplot(2,2,1),imshow('coastguard_95.tif');
subplot(2,2,2),imshow(first_order_Mar);
subplot(2,2,3),imshow(coastguard_det_res);
subplot(2,2,4),imshow(second_order_Mar);


%-------------------------------------------------------------------------
% I try to do motion compensation to surpress the different caused by a
% moving camera
%
%     res = abs(next_f - prev_f);
%     resL = [sum(sum(res))];
%     for i = 1:10
%         shift = [ next_f(:,1:i) next_f(:,1:size(next_f,2)-i) ];
%         res = abs(shift - prev_f);
%         resL = [resL sum(sum(res))];
%     end
%     imshow(shift)
%-------------------------------------------------------------------------

[H,W] = size(next_f);

shift_next = [ next_f(:,1:4), next_f(:,1:W-4) ];

Sig = 7;
coastguard_det_res = shs2016f_static_thre(prev_f,shift_next,Sig);

T = 12;
first_order_Mar = shs2016f_adapt_thre( prev_f,shift_next,coastguard_det_res,Sig,T);
second_order_Mar = shs2016f_adapt_thre( prev_f,shift_next,first_order_Mar,Sig,T);

figure('Name','coastguard_compensation','NumberTitle','off');
subplot(2,2,1),imshow('coastguard_95.tif');
subplot(2,2,2),imshow(first_order_Mar);
subplot(2,2,3),imshow(coastguard_det_res);
subplot(2,2,4),imshow(second_order_Mar);