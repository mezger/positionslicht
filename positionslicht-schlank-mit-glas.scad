module laterne(led=3, winkel=112.5)
{
    deckeldicke=1;
    mittenhoehe=1.5*led;
    mittenradius=led/2+1;
    bevel=0.3;
    
    //Boden
    difference()
    {
        //Sockel
        cylinder(h=deckeldicke,d=led+2.5);
        //Bohrung für LED-Rand
        cylinder(h=deckeldicke,d=led+1);
    }
    
    //Mitte
    difference()
    {
        union()
        {
            //Zylinder mit Abstrahlöffnung
            difference()
            {
                translate([0,0,deckeldicke]) cylinder(h=mittenhoehe,r=mittenradius);
                //Abstrahlöffnung
                translate([0,0,deckeldicke]) sector(h=mittenhoehe, d=led*2, a1=0, a2=winkel);
            }
            //Lampenglas
            translate([0,0,deckeldicke]) lampenglas(led);
        }
        //LED-Bohrung
        translate([0,0,deckeldicke]) cylinder(h=mittenhoehe,d=led+0.2);
    }
    
    //Deckel
    hull()
    {
        translate([0,0,mittenhoehe+deckeldicke]) cylinder(h=deckeldicke-bevel,d=led+2.5);
        translate([0,0,mittenhoehe+2*deckeldicke-bevel]) cylinder(h=bevel,d=led+2.5-bevel);
    }
}

/*
cylinder sector https://gist.github.com/plumbum/78e3c8281e1c031601456df2aa8e37c6
*/
module sector(h, d, a1, a2) 
{
    if (a2 - a1 > 180) 
    {
        difference() 
        {
            cylinder(h=h, d=d);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } 
    else 
    {
        difference() 
        {
            cylinder(h=h, d=d);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5]) cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5]) cube([d, d/2, h+1]);
        }
    }
}

/* 
led = LED-Durchmesser (3mm oder 5mm)
*/
module lampenglas(led=3)
{
    hoehe=1.5*led;
    radius=led/2+1;
    lamellenhoehe=hoehe/7;
    ringradius=0.9; //Radius minus Loch

    rotate_extrude($fn=200) //auskommentieren um Profil zu sehen
        translate([led/2+0.1,0]) //für inneres Loch für LED
            union()
            {
                //Lamellen oben und unten
                color("Green", 1.0) 
                    polygon(points=[
                        [0,0],[0.6,0],
                        [0.8,lamellenhoehe],[0.6,lamellenhoehe],
                        [0.8,2*lamellenhoehe],[0.6,2*lamellenhoehe],
                        [0.6,hoehe-2*lamellenhoehe],[0.8,hoehe-2*lamellenhoehe],
                        [0.6,hoehe-lamellenhoehe],[0.8,hoehe-lamellenhoehe],
                        [0.6,hoehe],[0,hoehe]
                    ] );
                //mittlerer Ring (halbe Ellipse)
                difference()
                {
                    translate([0,hoehe/2]) scale([1,hoehe/3]) circle(r=ringradius);
                    translate([-ringradius,0]) square([ringradius,hoehe]);
                }
            }
}


//Positionslaterne 112.5°
//Hecklicht 135°
//Topplicht 225°
//LED-Größen 3mm oder 5mm
$fn=100;
laterne(3, 135);
