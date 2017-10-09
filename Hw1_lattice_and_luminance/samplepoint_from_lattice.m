function [ xyz ] = samplepoint_from_lattice( Lat,n )
%DRAW_FROM_LATTICE Summary of this function goes here
%   Detailed explanation goes here

res = [0;0;0];
for i = 1:3*n
    
    if i == 1
        pre_ord = Lat;
        res = [res,Lat];
    else
        [~,k] = size(pre_ord);
        new_order = zeros(3,6*k);
        for j = 1:k
            new_order(:,6*j-5:6*j-3) = repmat(pre_ord(:,j),1,3) + Lat;
            new_order(:,6*j-2:6*j) = repmat(pre_ord(:,j),1,3) - Lat;
        end
        new_order = unique(new_order.','rows').';
        new_order( :, all(~new_order,1) ) = [];
        new_order(:,any(new_order>n)) = [];
        new_order(:,any(new_order<0)) = [];
        res = [res,new_order];
        pre_ord = new_order;
    end
end
xyz = unique(res.','rows').';
xyz(:,any(xyz>n)) = [];
xyz(:,any(xyz<0)) = [];
xyz = sortrows(xyz.',3).';
end

