use <../basics/cube_fillet.scad>;
use <../components/db9/db9_negative.scad>;


inner_tol = 1;
wall_thickness = 1;
standoff_height = 6;
box_height = 14;
box_inner = [53.3 + 2*inner_tol, 68.6 + 2*inner_tol, box_height + standoff_height];
box_outer = [box_inner[0] + 2*wall_thickness, box_inner[1] + 2*wall_thickness, box_inner[2] + wall_thickness - 0.01];

difference(){
    translate([box_outer[0] * 0.5, box_outer[1] * 0.5,box_outer[2] * 0.5,]){
        cube_fillet(box_outer, 1);
        translate([0, 0, wall_thickness]){
            cube_fillet(box_inner, 1);
        }
    }
    // serial ports
    translate([20, 1.01, 10]){
        rotate([90,0,0]){
            db9_negative();
        }
    }
};