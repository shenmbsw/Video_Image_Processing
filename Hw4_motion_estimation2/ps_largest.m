function ps_largest()
    H = 288;
    W = 352;

    [X,Y] = meshgrid(1:W,H:-1:1);
    X = X - 1;
    Y = Y - 1;
    X(X>W/2) = X(X>W/2) - W;
    Y(Y>H/2) = Y(Y>H/2) - H;
    Y = -Y;

    this_pic = imread('missa_80.tif');
    next_pic = imread('missa_84.tif');

    [ F,row,col ] = find_f(this_pic,next_pic);
    subplot(2,2,1)
    surf(X,Y,F)
    title('missa: d1 = [-2,7] d2 = [1,7], d3 = [-2,8]')
    xlabel('width')
    ylabel('height')
    colorbar

    this_pic = imread('container_1.tif');
    next_pic = imread('container_30.tif');
    [ F,row,col ] = find_f(this_pic,next_pic);
    subplot(2,2,2)
    surf(X,Y,F)
    title('container: d1 = [0,0] d2 = [0,7], d3 = [0,6]')
    xlabel('width')
    ylabel('height')
    colorbar

    this_pic = imread('coastguard_90.tif');
    next_pic = imread('coastguard_95.tif');
    [ F,row,col ] = find_f(this_pic,next_pic);
    subplot(2,2,3)
    surf(X,Y,F)
    title('coastguard: d1 = [0,-4] d2 = [1,-4], d3 = [0,5]')
    xlabel('width')
    ylabel('height')
    colorbar
end

function [ F,row,col ] = find_f( this_pic,next_pic )
[H,W] = size(this_pic);

F = phase_correlation(this_pic,next_pic);

sortedF = sort(F(:),1,'descend');
d1 = sortedF(1);
d2 = sortedF(2);
d3 = sortedF(3);

row = zeros(3,1);
col = zeros(3,1);

% find the most three biggest index
[row(1),col(1),~] = find(F==d1);
[row(2),col(2),~] = find(F==d2);
[row(3),col(3),~] = find(F==d3);

% the coordinate start from (1,1), so we do a compensation.
row = row-1;
col = col-1;
row(row>H/2) = row(row>H/2) - H;
col(col>W/2) = col(col>W/2) - W;
col = -col;

end

