function draw_samplepoint(xyz,type)
%DRAW_SAMPLEPOINT Summary of this function goes here
%   Detailed explanation goes here
    X=xyz(1,:);
    Y=xyz(2,:);
    Z=xyz(3,:);

    c = linspace(1,10,length(Z));

    figure('Name','Lattice Plot');
        scatter3(X,Y,Z,15,c,'filled');
        title('Projection of lattice')
        xlabel('x axis');
        ylabel('y axis');
        if type == 0
            zlabel('time t');
        elseif type == 1
            zlabel('frequency f');
        else
            error('Input wrong type');
end

