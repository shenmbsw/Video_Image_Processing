x1 = -2:0.1:-1.1
y1 = 0.5 * x1.^3 + 2.5* x1.^2 + 4 * x1 + 2;
x2 = -1:0.1:-0.1;
y2 = -1.5 * x2.^3 - 2.5* x2.^2 + 1;
x3 = 0.1:0.1:1;
y3 = 1.5 * x3.^3 - 2.5* x3.^2 + 1;
x4= 1.1:0.1:2
y4 = -0.5 * x4.^3 + 2.5* x4.^2 - 4 * x4 + 2;

xx = [x1,x2,x3,x4]
yy = [y1,y2,y3,y4]

plot(xx,yy)

w = conv(u,v)

x = 0:10;
y = x.^2;
xx = linspace(0,10);
yy = lagrange(xx,x,y);
plot(x,y,'o',xx,yy,'.')