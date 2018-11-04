//NOT USED RIGHT NOW!!! FIX ME!!!! WHY IS THIS DIRTY AF?
handle_width = 10;
handle_depth = 5;
handle_height = 25;

base_height = 3;


back_draft = 8;

//module to create one entire handle of the finished model.
module handle() {
    difference() {
        hull() {
            cube([5, 30, 5], center=true);
            translate([0,back_draft,-handle_height])
                rotate([0,90,0])
                    cylinder(d = 20, h = 5, center=true);
        };
        translate([-5,back_draft,-handle_height])
            rotate([0,90,0])
                cylinder(d=3.25, h=10, $fn=30);
    }
}

//mesh of the wheel.
//try to do as little friction on the ground as possible.
translate([0,back_draft,-handle_height - base_height + 0.1])
    rotate([0,90,0])
        difference(){
            union(){
                rotate_extrude(){
                    translate([14,0,0])
                        circle(r=4);
                };
                cylinder(r=16, h=5, center=true, $fn=20);
                cylinder(r=5, h = 10, center=true);
            }
            cylinder(d=3.25, h=20, center=true, $fn=20);
        }

//hole for fixing to z-axis.
difference(){
    cylinder(d=40, h=base_height, center=true, $fn=40);
    cylinder(d=3.5, h=20, center=true, $fn=40);
}

//left handle
translate([8,0,-base_height + 0.1])
    handle();

//right handle
translate([-8,0,-base_height + 0.1])
    handle();