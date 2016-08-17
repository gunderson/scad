inner_tol = 1;
wall_thickness = 1;
standoff_height = 6;
box_inner = [53.3 + 2*inner_tol, 68.6 + 2*inner_tol, 14 + standoff_height];

difference(){
    cube([box_inner[0] + 2*wall_thickness, box_inner[1] + 2*wall_thickness, box_inner[2] + wall_thickness - 0.01], false);
    translate([wall_thickness, wall_thickness, wall_thickness]){
        cube(box_inner, false);
    }
};