//Positionslaterne 112.5°
//Hecklicht 135°
//Topplicht 225°
//LED-Größen 3mm oder 5mm

led=3;
winkel=112.5;
deckelseparat=false;

/* abgeleitete Werte */

spalt=0.1;
wand=0.8;
ueberstand=0.6;

bodendicke=1.4;

deckeldicke=1.2;
deckelradius=led/2+spalt+wand+ueberstand;
bevel=0.4;

mittenhoehe=1.5*led;
mittenradius=led/2+spalt+wand;

$fn=100;


laterne();
if(deckelseparat)
{
    translate([3*led,0,0]) deckel();
}


module laterne()
{
    //Boden
    difference()
    {
        cylinder(h=bodendicke,r=deckelradius);
        cylinder(h=bodendicke,r=led/2+spalt); //Ausschnitt LED
        cylinder(h=1.3,r=led/2+spalt+0.4); //Ausschnitt LED-Ring
    }
    //Mitte
    difference()
    {
        translate([0,0,bodendicke]) cylinder(h=mittenhoehe,r=mittenradius);
        union()
        {
            translate([0,0,bodendicke]) cylinder(h=mittenhoehe,r=led/2+spalt);
            translate([0,0,bodendicke]) sector(mittenhoehe,mittenradius*2+0.1,0,winkel); //Öffnung
        }
    }
    //Deckel
    if(!deckelseparat)
    {
        translate([0,0,mittenhoehe+bodendicke]) deckel();
    }
}

module deckel()
{
    hull()
    {
        cylinder(h=deckeldicke-bevel,r=deckelradius); //unterer Teil
        translate([0,0,deckeldicke-bevel]) cylinder(h=bevel,r=deckelradius-bevel); //oberer Teil mit Bevel
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

