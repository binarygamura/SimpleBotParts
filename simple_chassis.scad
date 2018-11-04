bot_length = 180;
bot_width = 68;
default_elem_height = 3;


module m25_elevated_whole(xpos, ypos) {
    union() {
        translate([xpos, ypos, 3]) {
            difference() {
                cylinder(d = 6, h = default_elem_height + 1, $fn=20);                
                translate([0,0,-3]) cylinder(d = 3.25, h = default_elem_height + 15, $fn=20);
            }
        }
    }
}

module m20_elevated_hole(xpos, ypos) {    
    union() {
        translate([xpos, ypos, 3]) {
            difference() {
                cylinder(d = 5, h = default_elem_height, $fn=20);                
                translate([0,0,-1]) cylinder(d = 2.25, h = default_elem_height + 1.1, $fn=20);
            }
        }
    }
}

module rounded_plate(width, length, height, radius) {
    half_r = radius / 2;
    resolution = 30;
    hull() {
        translate([half_r, half_r, 0])
            cylinder(h=height, d=radius, $fn=resolution);
        translate([width - half_r, half_r,0])
            cylinder(h=height, d=radius, $fn=resolution);
        translate([0 + half_r, length - half_r,0])
            cylinder(h=height, d=radius, $fn=resolution);
        translate([width - half_r, length - half_r,0])
            cylinder(h=height, d=radius, $fn=resolution);
    }
}

module base_plate() {
    //Abstand der Bohrungen des RPI in mm.
    raspi_width = 49;
    rasp_length = 58;
    
    //Abstand auf der y-Achse der Bohrungen des RPi.
    y_offset = (bot_width - raspi_width) / 2;
    //Positionen der einzelnen Bohrungen für den RPi.
    rpi_pos = [
        [y_offset, 23.5],
        [bot_width - y_offset, 23.5],
        [y_offset, 23.5 + rasp_length],
        [bot_width - y_offset, 23.5 + rasp_length]];
    
    //Abstand der Bohrungen auf dem L298N. Die Bohrungen ergeben als Form ein Quadrat.
    l298n_len = 38;
    l298n_y_offset = (bot_width - l298n_len) / 2;
    l298n_pos = [
        [l298n_y_offset, rasp_length + 23.5 + 20],
        [bot_width - l298n_y_offset, rasp_length + 23.5 + 20],
        [l298n_y_offset, rasp_length + 23.5 + 20 + l298n_len],
        [bot_width - l298n_y_offset, rasp_length + 23.5 + 20 + + l298n_len]];
    
    //Abstand der Bohrungen auf dem Motorblock zu einander.
    gears_width = 60;
    gears_y_offset = (bot_width - gears_width) / 2;
    
    drill_diameter = 3.25;
    
    difference() {
        rounded_plate(bot_width, bot_length, default_elem_height, 20);
//        cube([bot_width, bot_length, default_elem_height]);
        
        //Bohrungen für den RPaspberry.
        translate([rpi_pos[0][0], rpi_pos[0][1],-5]) 
            cylinder(d = drill_diameter, h = default_elem_height + 13, $fn=20);
        translate([rpi_pos[1][0], rpi_pos[1][1],-5]) 
            cylinder(d = drill_diameter, h = default_elem_height + 13, $fn=20);
        translate([rpi_pos[2][0], rpi_pos[2][1],-5]) 
            cylinder(d = drill_diameter, h = default_elem_height + 13, $fn=20);
        translate([rpi_pos[3][0], rpi_pos[3][1],-5]) 
            cylinder(d = drill_diameter, h = default_elem_height + 13, $fn=20);
        
        //Bohrungen für den L298N.
        translate([l298n_pos[0][0], l298n_pos[0][1],-5]) 
            cylinder(d = drill_diameter, h = default_elem_height + 13, $fn=20);
        translate([l298n_pos[1][0], l298n_pos[1][1],-5]) 
            cylinder(d = drill_diameter, h = default_elem_height + 13, $fn=20);
        translate([l298n_pos[2][0], l298n_pos[2][1],-5]) 
            cylinder(d = drill_diameter, h = default_elem_height + 13, $fn=20);
        translate([l298n_pos[3][0], l298n_pos[3][1],-5]) 
            cylinder(d = drill_diameter, h = default_elem_height + 13, $fn=20);
        
        //Bohrungen für die Motoren samt Getriebe.
        translate([gears_y_offset, 18,-5]) 
            cylinder(d = 3.25, h = default_elem_height + 13, $fn=20);
        translate([bot_width - gears_y_offset, 18,-5])     
            cylinder(d = 3.25, h = default_elem_height + 13, $fn=20);
        
        //Aussparungen für die Kabelführung durch die Bodenplatte.
        translate([8, rpi_pos[3][1] - 35, -0.1])
            cube([20, 10, 11]);
        translate([bot_width - 20 - 8, rpi_pos[3][1] - 35, -0.1])
            cube([20, 10, 11]);
            
        //Aussparungen für die Kabelführung durch die Bodenplatte.
        translate([8, rpi_pos[3][1] + 5, -0.1])
            cube([20, 10, 11]);
        translate([bot_width - 20 - 8, rpi_pos[3][1] + 5, -0.1])
            cube([20, 10, 11]);
            
        //Aussparungen für die Kabelführung durch die Bodenplatte.
        translate([8, rpi_pos[3][1] + 35, -0.1])
            cube([20, 10, 11]);
        translate([bot_width - 20 - 8, rpi_pos[3][1] + 35, -0.1])
            cube([20, 10, 11]);

        //Bohrung für das Heckrad.
        translate([bot_width / 2, bot_length - 21, -1])
            cylinder(d = 3.5, h = default_elem_height + 13, $fn=20);
                    
        
    };
    //Grate zur Erhöhung der Stabilität
    translate([0,25,default_elem_height - 0.2])
        cube([4,bot_length - 55,3]);
    translate([bot_width - 4,25,default_elem_height - 0.2])
        cube([4,bot_length - 55,3]);
    translate([bot_width / 2 - 2,25,default_elem_height - 0.2])
        cube([4,bot_length - 55,3]);
    
    // Sockel für den Raspberry-PI.
    for (pos = rpi_pos) {
        m25_elevated_whole(pos[0], pos[1]);
    }
    
    // Sockel für den L298N.
    for (pos = l298n_pos) {
        m25_elevated_whole(pos[0], pos[1]);
    }    
    
    
}


base_plate();
