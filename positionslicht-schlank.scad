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
        cylinder(h=deckeldicke,d=led+2.5,$fn=100);
        //Bohrung für LED-Rand
        cylinder(h=deckeldicke,d=led+1,$fn=100);
    }
    
    //Mitte
    difference()
    {
        translate([0,0,deckeldicke]) cylinder(h=mittenhoehe,r=mittenradius,$fn=100);
        union()
        {
            //LED-Bohrung
            translate([0,0,deckeldicke]) cylinder(h=mittenhoehe,d=led+0.2,$fn=100);
            //Abstrahlöffnung
            translate([0,0,deckeldicke]) sector(h=mittenhoehe, d=led*2, a1=0, a2=winkel);
        }
    }
    
    //Deckel
    hull()
    {
        translate([0,0,mittenhoehe+deckeldicke]) cylinder(h=deckeldicke-bevel,d=led+2.5,$fn=100);
        translate([0,0,mittenhoehe+2*deckeldicke-bevel]) cylinder(h=bevel,d=led+2.5-bevel,$fn=100);
    }
}

//cylinder sector https://gist.github.com/plumbum/78e3c8281e1c031601456df2aa8e37c6
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

//Positionslaterne 112.5°
//Hecklicht 135°
//Topplicht 225°
//LED-Größen 3mm oder 5mm
laterne(3, 135);
