// use $fn % 4 = 0;
module cube_fillet(lwh=[1,1,1], r=0.1, edge_scales=[1,2,2,1], edge_offsets=[0,0,0,0], $fn=32, center=true) {
    $fn = ceil($fn / 4) * 4;
    
    corner_rotation = 180 / $fn;
    fudge = 1/cos(180/$fn);
    fr = r;// * fudge;
    
    center_translation = center ? [0,0,0] : [lwh[0] * 0.5, lwh[1] * 0.5, lwh[2] * 0.5, ];
    
    half_lwh = [lwh[0] * 0.5, lwh[1] * 0.5, lwh[2] * 0.5];
    half_edge_offsets = [edge_offsets[0] * 0.5, edge_offsets[1] * 0.5, edge_offsets[2] * 0.5, edge_offsets[3] * 0.5];
    
    cornerNE = [
        half_lwh[0] * edge_scales[0] + half_edge_offsets[0],
        half_lwh[1] * edge_scales[1] + half_edge_offsets[1],
        -half_lwh[2]
    ];
    cornerSE = [
        (half_lwh[0] * edge_scales[2] + half_edge_offsets[2]),
        -(half_lwh[1] * edge_scales[1] + half_edge_offsets[1]),
        -half_lwh[2]
    ];
    
    cornerSW = [
        -(half_lwh[0] * edge_scales[2] + half_edge_offsets[2]),
        -(half_lwh[1] * edge_scales[3] + half_edge_offsets[3]),
        -half_lwh[2]
    ];
    
    cornerNW = [
        -(half_lwh[0] * edge_scales[0] + half_edge_offsets[0]),
        (half_lwh[1] * edge_scales[3] + half_edge_offsets[3]),
        -half_lwh[2]
    ];
    
    corner_angles = [
        atan2(cornerSE[1] - cornerNE[1], cornerSE[0] - cornerNE[0]),
        atan2(cornerSW[1] - cornerSE[1], cornerSW[0] - cornerSE[0]),
        atan2(cornerNW[1] - cornerSW[1], cornerNW[0] - cornerSW[0]),
        atan2(cornerNE[1] - cornerNW[1], cornerNE[0] - cornerNW[0])
    ];
    
    box_points = [
        [cornerNE[0] - r - r * cos(corner_angles[3] - 90), cornerNE[1] - r - r * sin(corner_angles[3] - 90)],
        [cornerNE[0] - r - r * cos(corner_angles[0] - 90), cornerNE[1] - r - r * sin(corner_angles[0] - 90)],
        
        [cornerSE[0] - r - r * cos(corner_angles[0] - 90), cornerSE[1] + r - r * sin(corner_angles[0] - 90)],
        [cornerSE[0] - r - r * cos(corner_angles[1] - 90), cornerSE[1] + r - r * sin(corner_angles[1] - 90)],
        
        [cornerSW[0] + r - r * cos(corner_angles[1] - 90), cornerSW[1] + r - r * sin(corner_angles[1] - 90)],
        [cornerSW[0] + r - r * cos(corner_angles[2] - 90), cornerSW[1] + r - r * sin(corner_angles[2] - 90)],
        
        [cornerNW[0] + r - r * cos(corner_angles[2] - 90), cornerNW[1] - r - r * sin(corner_angles[2] - 90)],
        [cornerNW[0] + r - r * cos(corner_angles[3] - 90), cornerNW[1] - r - r * sin(corner_angles[3] - 90)],
    ];
    
    box_paths = [[ 0,1,2,3,4,5,6,7]];
    
    translate(center_translation){
        translate([cornerNE[0], cornerNE[1], cornerNE[2]]){
            cube([0.5,0.5,0.5], true);
        }
        translate([cornerSE[0], cornerSE[1], cornerSE[2]]){
            cube([0.5,0.5,0.5], true);
        }
        translate([cornerSW[0], cornerSW[1], cornerSW[2]]){
            cube([0.5,0.5,0.5], true);
        }
        translate([cornerNW[0], cornerNW[1], cornerNW[2]]){
            cube([0.5,0.5,0.5], true);
        }
        
       // union(){
            //corners
            //NE
            
            translate([cornerNE[0] - r, cornerNE[1] - r, cornerNE[2]]){
                // orient cylinder edges to match box
                rotate([0,0,corner_rotation]){
                    cylinder(h=lwh[2], r=fr, $fn=$fn);
                }
            }
            //SE
            translate([cornerSE[0] - r, cornerSE[1] + r, cornerSE[2]]){ 
                
                rotate([0,0,corner_rotation]){
                    cylinder(h=lwh[2], r=fr, $fn=$fn);
                }
            }
            //SW
            translate([cornerSW[0] + r, cornerSW[1] + r, cornerSW[2]]){ 
                
                rotate([0,0,corner_rotation]){
                    cylinder(h=lwh[2], r=fr, $fn=$fn);
                }
            }
            //NE
            translate([cornerNW[0] + r, cornerNW[1] - r, cornerNW[2]]){ 
                rotate([0,0,corner_rotation]){
                    cylinder(h=lwh[2], r=fr, $fn=$fn);
                }
            }
            
            translate([0,0,-0.25 * lwh[2]]){ 
                linear_extrude(height=lwh[2]){
                    polygon(paths = box_paths, points = box_points);
                }
            }
            
            // boxes
            //cube([lwh[0] - 2*r, lwh[1], lwh[2]], true);
            //cube([lwh[0], lwh[1] - 2*r, lwh[2]], true);
       // }
    }
};

cube_fillet($fn=32, center=false);