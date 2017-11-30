fy = -0.5:0.01:0.5;
ft = -0.5:0.01:0.5;

[gfy,gft] = meshgrid(fy,ft);

subplot(3,3,1)
h = [0.5,1,0.5];
y = [0,0,0];
t = [-1,0,1];
stem3(t,y,h)
xlabel('t')
ylabel('y')
amp = 1+cos(2*pi*gft);
subplot(3,3,2)
mesh(gft,gfy,amp);
xlabel('ft')
ylabel('fy')
title('temporal two-field averaging')
subplot(3,3,3)
contour(gft,gfy,amp)
xlabel('ft')
ylabel('fy')

subplot(3,3,4)
h = [0,0.25,0,0.25,1,0.25,0,0.25,0];
y = [-1,-1,-1, 0,0,0, 1,1,1];
t = [-1, 0, 1,-1,0,1,-1,0,1];
stem3(t,y,h)
xlabel('t')
ylabel('y')
amp = 1+0.5*cos(2*pi*gft)+0.5*cos(2*pi*gfy);
subplot(3,3,5)
mesh(gft,gfy,amp);
xlabel('ft')
ylabel('fy')
title(' joint non-causal line and field averaging')
subplot(3,3,6)
contour(gft,gfy,amp)
xlabel('ft')
ylabel('fy')

subplot(3,3,7)
h = [0,0,0,0,0,0,0,-1,0,9,32,9,0,-1,0,0,0,16,0,0,0]/32;
y = [-3,-2,-1,0,1,2,3,-3,-2,-1,0,1,2,3,-3,-2,-1,0,1,2,3];
t = [-1,-1,-1,-1,-1,-1,-1, 0,0,0,0,0,0,0,1,1,1,1,1,1,1];
stem3(t,y,h)
xlabel('t')
ylabel('y')
a = (1 + 9/16*cos(2*pi*gfy) - 1/16*cos(6*pi*gfy) + 1/2*cos(2*pi*gft))^2;
b = 1/2*sin(2*pi*gft)^2
amp = abs( (a+b)^0.5);
subplot(3,3,8)
mesh(gft,gfy,amp);
xlabel('ft')
ylabel('fy')
title(' joint causal line and field averaging')
subplot(3,3,9)
contour(gft,gfy,amp)
xlabel('ft')
ylabel('fy')

