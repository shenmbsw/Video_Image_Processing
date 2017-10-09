clear all

Lat.VP = [1 0 0;
          0 1 0;
          0 0 1];
Lat.LI = [1 0 0;
          0 1 0.5;
          0 0 1];
Lat.FQ = [1 0 0.5;
          0 1 0.5;
          0 0 1];

      
Rec.VP = inv(Lat.VP).';
Rec.LI = inv(Lat.LI).';
Rec.FQ = inv(Lat.FQ).';


n = 10;
xyz = samplepoint_from_lattice(Lat.LI,n);
draw_samplepoint(xyz,0);

xyz_rec = samplepoint_from_lattice(Rec.LI,n);
draw_samplepoint(xyz_rec,1);

find_vio_xyz = xyz;
find_vio_xyz(:,any((xyz>7 | xyz<3 ))) = [];
draw_voro(find_vio_xyz)
