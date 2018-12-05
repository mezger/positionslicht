/* 
Lampenglas
*/
module lampenglas(led=3)
{
    hoehe=1.5*led;
    radius=led/2+1;
    lamellenhoehe=hoehe/7;
    ringradius=0.9; //Radius minus Loch
    lammellenradius1=radius;
    lammellenradius2=lammellenradius1-0.2;

    rotate_extrude($fn=200) //auskommentieren um Profil zu sehen
        union()
        {
            //Lamellen oben und unten
            color("Green", 1.0) 
                polygon(points=[
                    [0,0],[lammellenradius2,0],
                    [lammellenradius1,lamellenhoehe],[lammellenradius2,lamellenhoehe],
                    [lammellenradius1,2*lamellenhoehe],[lammellenradius2,2*lamellenhoehe],
                    [lammellenradius2,hoehe-2*lamellenhoehe],[lammellenradius1,hoehe-2*lamellenhoehe],
                    [lammellenradius2,hoehe-lamellenhoehe],[lammellenradius1,hoehe-lamellenhoehe],
                    [lammellenradius2,hoehe],[0,hoehe]
                ] );
            //mittlerer Ring
            translate([led*0.55,hoehe/2]) 
                scale([1,hoehe/3]) 
                    circle(r=ringradius);
        }
}

$fn=50;
lampenglas(3);