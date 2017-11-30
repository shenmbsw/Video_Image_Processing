[h,w,c] = size(imread('horses_interl/horses_interl_1.tif'));
H = h*2;
F = {};
for i = 1:2:59
    name_1=strcat('horses_interl/horses_interl_',num2str(i+1),'.tif');
    frame1 = imread(name_1);
    name_2=strcat('horses_interl/horses_interl_',num2str(i),'.tif');
    frame2 = imread(name_2);
    show_frame1 = zeros(H,w,c,'uint8');
    show_frame2 = zeros(H,w,c,'uint8');
    for m = 1:2:H
        j = (m+1)/2;
        show_frame1(m,:,:) = frame1(j,:,:);
        show_frame2(m+1,:,:) = frame2(j,:,:);
    end

    F{i} = show_frame1;
    F{i+1} = show_frame2;
    
end
close all

name =strcat('horses0.avi');
v = VideoWriter(name);
open(v);
for i = 1:60
    this_frame =  F{i};
    writeVideo(v,this_frame);
end
close(v);

h = {};
h{1} = 1/2*[0,1,0;0,2,0;0,1,0];
h{2} = 1/16*[0,1,0;0,0,0;0,7,0;0,16,0;0,7,0;0,0,0;0,1,0];
h{3} = 1*[0,0,0;0,1,1;0,0,0];
h{4} = 1/2*[0,0,0;1,2,1;0,0,0];
h{5} = 1/4*[0,1,0;1,4,1;0,1,0];
h{6} = 1/32*[0,-1,0;0,0,0;0,9,0;0,32,16;0,9,0;0,0,0;0,-1,0];

for n = 1:6
    fliter = h{n};
    write_frame = zeros(360,640,60,3,'uint8');
    for x = 1:640
        y_t_plane = zeros(360,60,3);
        for i = 1:60
            f = F{i};
            y_t_plane(:,i,:) = f(:,x,:);
        end
        y_t_plane(:,:,1) = filter2(fliter,y_t_plane(:,:,1));
        y_t_plane(:,:,2) = filter2(fliter,y_t_plane(:,:,2));
        y_t_plane(:,:,3) = filter2(fliter,y_t_plane(:,:,3));
        write_frame(:,x,:,:) = ceil(y_t_plane);    
    end
    name =strcat('horses',num2str(n),'.avi');
    v = VideoWriter(name);
    open(v);
    for i = 1:60
        this_frame = zeros(360,640,3,'uint8');
        this_frame(:,:,1) = write_frame(:,:,i,1);
        this_frame(:,:,2) = write_frame(:,:,i,2);
        this_frame(:,:,3) = write_frame(:,:,i,3);
        writeVideo(v,this_frame);
    end
    close(v);
end
