fy = -0.5:0.01:0.5;
ft = -0.5:0.01:0.5;

[gfy,gft] = meshgrid(fy,ft);

subplot(3,3,1)
h = [0.5,1,0.5];
y = [-1,0,1];
t = [0,0,0];
stem3(t,y,h)
xlabel('t')
ylabel('y')
amp = 1 + cos(2*pi*gfy);
subplot(3,3,2)
mesh(gft,gfy,amp);
xlabel('ft')
ylabel('fy')
title('vertical two-line averaging')
subplot(3,3,3)
contour(gft,gfy,amp)
xlabel('ft')
ylabel('fy')

subplot(3,3,4)
h = [1,0,7,16,7,0,1,1,0,7,16,7,0,1,1,0,7,16,7,0,1]/16;
y = [-3,-2,-1,0,1,2,3,-3,-2,-1,0,1,2,3,-3,-2,-1,0,1,2,3];
t = [-1,-1,-1,-1,-1,-1,-1, 0,0,0,0,0,0,0,1,1,1,1,1,1,1];
stem3(t,y,h)
xlabel('t')
ylabel('y')
amp = 1 + 7/8*cos(2*pi*gfy) + 1/8*cos(6*pi*gfy);
subplot(3,3,5)
mesh(gft,gfy,amp);
xlabel('ft')
ylabel('fy')
title('vertical four-line averaging')
subplot(3,3,6)
contour(gft,gfy,amp)
xlabel('ft')
ylabel('fy')

subplot(3,3,7)

h = [0,1,1];
y = [0,0,0];
t = [-1,0,1];
stem3(t,y,h)
xlabel('t')
ylabel('y')
amp = abs((2 + 2 * cos(2*pi*gft))^0.5);
subplot(3,3,8)
mesh(gft,gfy,amp);
xlabel('ft')
ylabel('fy')
title(' temporal zero-hold')
subplot(3,3,9)
contour(gft,gfy,amp)
xlabel('ft')
ylabel('fy')
