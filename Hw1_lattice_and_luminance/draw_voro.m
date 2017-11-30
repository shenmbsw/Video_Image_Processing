function draw_voro( xyz )
%DRAW_VORO Summary of this function goes here
%   Detailed explanation goes here
    VX=xyz(1,:);
    VY=xyz(2,:);
    VZ=xyz(3,:);

%     figure('Name','All_Voronoin_cell');
%     scatter3(VX,VY,VZ,15,'filled');
%     title('Voronoin')
%     [v,c] = voronoin(xyz.');
%     for i = 1:length(c) 
%         if all(c{i}~=1)
%             patch(v(c{i},1),v(c{i},2),v(c{i},3),i);
%         end
%     end
%     title('Voronoi Region and sample point')

    figure('Name','One_Voronoin_cell');

    DT = delaunayTriangulation(VX.',VY.',VZ.');
    [V,R] = voronoiDiagram(DT);

    for i = 1:length(R) 
        if all(R{i}~=1)
            XR10 = V(R{i},:);
            K = convhull(XR10);
            trisurf(K, XR10(:,1) ,XR10(:,2) ,XR10(:,3))
        end
    end

    title('3-D Voronoi Region')
end

