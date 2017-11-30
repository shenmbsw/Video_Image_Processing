F_gt = {};
for i = 1:60
    name=strcat('horses_prog/horses_prog_',num2str(i),'.tif');
    frame = imread(name);
    [h,w,c] = size(frame);
    H = h*2;
    F_gt{i} = frame;
end

name =strcat('horses_groundtruth.avi');
v = VideoWriter(name);
open(v);
for i = 1:60
    this_frame =  F_gt{i};
    writeVideo(v,this_frame);
end
close(v);

MSE = {};
for n = 1:6
    name =strcat('horses',num2str(n),'.avi');
    v = VideoReader(name);
    MSE{n} = 0;
    i = 1;
    while hasFrame(v)
        filtered_frame = readFrame(v);
        MSE{n} = MSE{n} + immse(filtered_frame,F_gt{i});
        i = i+1;
    end
    MSE{n} = MSE{n}/60;
end
MSE

figure()
name =strcat('horses2.avi');
v = VideoReader(name);
i = 1;
filtered_frame = readFrame(v);
filtered_frame = readFrame(v);
imshow(filtered_frame)
title('four line average')

figure()
name =strcat('horses4.avi');
v = VideoReader(name);
i = 1;
filtered_frame = readFrame(v);
filtered_frame = readFrame(v);
imshow(filtered_frame)
title('two-field averaging')


figure()
name =strcat('horses5.avi');
v = VideoReader(name);
i = 1;
filtered_frame = readFrame(v);
filtered_frame = readFrame(v);
imshow(filtered_frame)
title( 'joint non-causal line and field averaging')