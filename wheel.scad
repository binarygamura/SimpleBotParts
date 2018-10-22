
//Durchmesser des Reifens
wheel_diameter = 55;
//Profilbreite
wheel_thickness = 10;
//Anzahl an Profilkerben im Reifen
wheel_profiles = 30;


difference() {
    union() {
        //Felge
        difference() {
            cylinder( d = wheel_diameter, h = 5, $fn=wheel_profiles);
        }

        //Achsenbefestigung
        translate([0,0,5])
            difference() {
                cylinder( d = 10, h = 8, $fn=6);
                //Bohrung zur Fixierung.
                translate([0,0,5])
                    rotate([90,0,0])
                        cylinder(d=2.8, h = 20, $fn=50);
            }
            
            
        //Mantel des Reifens
        difference() {
            cylinder( d = wheel_diameter + 5, h = wheel_thickness);
            translate([0,0,-1])
                cylinder( d = wheel_diameter , h = wheel_thickness + 2);
            
        }

        //Profil des Reifens
        for(rotation = [0: 360 / wheel_profiles: 360 ]) {    
            rotate([0,0,rotation])
                translate([wheel_diameter / 2 + 3, 0, 0])
                        cylinder(d=5, h = wheel_thickness, $fn=3);
        }
    };
    //Bohrung für die Achse.
    translate([0,0,-1])
        cylinder( d = 3.5, h = 38, $fn=6);
}