function [ Ix,Iy,It ] = gradiance( this_pic,next_pic)
[H,W] = size(this_pic);
this_pic = double(this_pic);
next_pic = double(next_pic);

Ix = this_pic(1:H-1,2:W) - this_pic(1:H-1,1:W-1);
Ix = Ix + this_pic(2:H,2:W) - this_pic(2:H,1:W-1);
Ix = Ix + next_pic(1:H-1,2:W) - next_pic(1:H-1,1:W-1);
Ix = Ix + next_pic(2:H,2:W) - next_pic(2:H,1:W-1);
Ix = Ix*0.25;

Iy = this_pic(2:H,1:W-1) - this_pic(1:H-1,1:W-1);
Iy = Iy + this_pic(2:H,2:W) - this_pic(1:H-1,2:W);
Iy = Iy + next_pic(2:H,1:W-1) - next_pic(1:H-1,1:W-1);
Iy = Iy + next_pic(2:H,2:W) - next_pic(1:H-1,2:W);
Iy = Iy * 0.25;

It = next_pic(1:H-1,1:W-1) - this_pic(1:H-1,1:W-1);
It = It + next_pic(2:H,1:W-1) - this_pic(2:H,1:W-1);
It = It + next_pic(1:H-1,2:W) - this_pic(1:H-1,2:W);
It = It + next_pic(2:H,2:W) - this_pic(2:H,2:W);
It = It * 0.25;

Ix = [Ix ones(H-1,1)];
Ix = [Ix;ones(1,W)];
Iy = [Iy ones(H-1,1)];
Iy = [Iy;ones(1,W)];
It = [It ones(H-1,1)];
It = [It;ones(1,W)];

end

