use <../../basics/cube_fillet.scad>;
module db9_negative(){
    union(){
        //baseplate
        translate([0,0,-0.75]){
            cube_fillet([31,12.5,1.5], 1);
        }

        //connector

        translate([0,0,2.5]){
            cube_fillet([18, 9.5, 5], 1);
        }

        //mount holes
        translate([-12.5, 0, 0]){
            cylinder(h=5, r=1.55, $fn=20);
        }
        translate([12.5, 0, 0]){
            cylinder(h=5, r=1.55, $fn=20);
        }
    }
}

db9_negative();