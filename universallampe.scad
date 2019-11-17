/*
Sockel 220x220mm
Höhe von 255 mm ohne Griff, 305 mm mit Griff.
Durchmesser am Glas 160 mm.
*/
 
 
$fn=100;
scale=1;
 
h=255;
 
sul=220;   //Sockel unten Kantenlänge
suh=24;    //Sockel unten Höhe
sur=40;    //Sockel unten Eckradius
 
sd=200;   //Sockel Durchmesser
sh=26;    //Sockel Höhe
 
s3d=180;   //Sockel 3 Durchmesser
s3h=16;    //Sockel 3 Höhe
 
gd=160;   //Glas Durchmesser
gh=140;   //Glas Höhe
 
d1d=200;    //Deckel 1 Durchmesser
d1h=16;     //Deckel 1 Höhe
 
d2du=200;    //Deckel 1 Durchmesser
d2do=150;    //Deckel 1 Durchmesser
d2h=24;     //Deckel 1 Höhe
 
lampe();
//lamellen();
 
module lampe()
{
//Sockel unten (Grundplatte)
roundcube(sul,sul,suh,sur);

//Sockel (rund)
translate([0,0,suh]) cylinder(d=sd,h=sh);
 
//Sockel 3 (rund)
translate([0,0,suh+sh]) cylinder(d=s3d,h=s3h);
 
//Glas
//translate([0,0,suh+sh+s3h]) cylinder(d=gd,h=gh);
translate([0,0,suh+sh+s3h]) lamellen(gd);
translate([0,0,suh+sh+s3h+55]) cylinder(d=gd,h=30);
translate([0,0,suh+sh+s3h+55+30+55]) rotate([180,0,0]) lamellen(gd);

//Deckel
translate([0,0,suh+sh+s3h+gh]) cylinder(d=d1d,h=d1h);
translate([0,0,suh+sh+s3h+gh+d1h]) cylinder(d1=d2du,d2=d2do,h=d2h);
}
 
module roundcube(x,y,h,r)
{
    hull()
    {
        translate([-x/2+r, -y/2+r, 0]) cylinder(r=r,h=h);
        translate([x/2-r, -y/2+r, 0]) cylinder(r=r,h=h);
        translate([-x/2+r, y/2-r, 0]) cylinder(r=r,h=h);
        translate([x/2-r, y/2-r, 0]) cylinder(r=r,h=h);
    }
}

module lamellen(d=160)
{
    ri=d/2; //Radius Lamellen innen
    ro=ri*1.03; //Radius Lamellen außen
    hlg=55; //Höhe Lamellen gesamt

    rotate_extrude($fn=200) //auskommentieren um Profil zu sehen
        union()
        {
            //Lamellen unten
            color("Green", 1.0) 
                polygon(points=[
                    [0,0],[ri,0],
                    [ro,14/260*hlg],[ri,14/260*hlg], //14
                    [ro,29/260*hlg],[ri,29/260*hlg],
                    [ro,45/260*hlg],[ri,45/260*hlg],
                    [ro,62/260*hlg],[ri,62/260*hlg],
                    [ro,80/260*hlg],[ri,80/260*hlg],
                    [ro,99/260*hlg],[ri,99/260*hlg],
                    [ro,119/260*hlg],[ri,119/260*hlg],
                    [ro,140/260*hlg],[ri,140/260*hlg],
                    [ro,162/260*hlg],[ri,162/260*hlg],
                    [ro,185/260*hlg],[ri,185/260*hlg],
                    [ro,209/260*hlg],[ri,209/260*hlg],
                    [ro,234/260*hlg],[ri,234/260*hlg],
                    [ro,260/260*hlg],[0,260/260*hlg]
                ] );
        }
}
