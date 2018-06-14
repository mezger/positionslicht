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

$fn=50;
lampenglas(3);