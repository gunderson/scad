// use $fn % 4 = 0;
module cube_fillet(lwh=[1,1,1], r=0.1, $fn=8, center=true) {
    $fn = ceil($fn / 4) * 4;
    
    center_translation = center ? [0,0,0] : [lwh[0] * 0.5, lwh[1] * 0.5, lwh[2] * 0.5, ];
    
    translate(center_translation){
        union(){
            //corners
            //NE
            translate([lwh[0] * 0.5 - r, lwh[1] * 0.5 - r, -lwh[2]*0.5]){ 
                cylinder(h=lwh[2], r=r, $fn=$fn);
            }
            //SE
            translate([-(lwh[0] * 0.5 - r), lwh[1] * 0.5 - r, -lwh[2]*0.5]){
                cylinder(h=lwh[2], r=r, $fn=$fn);
            }
            //NE
            translate([-(lwh[0] * 0.5 - r), -(lwh[1] * 0.5 - r), -lwh[2]*0.5]){
                cylinder(h=lwh[2], r=r, $fn=$fn);
            }
            //SE
            translate([lwh[0] * 0.5 - r, -(lwh[1] * 0.5 - r), -lwh[2]*0.5]){
                cylinder(h=lwh[2], r=r, $fn=$fn);
            }
            
            // boxes
            cube([lwh[0] - 2*r, lwh[1], lwh[2]], true);
            cube([lwh[0], lwh[1] - 2*r, lwh[2]], true);
        };
    }
};

cube_fillet(center=false);