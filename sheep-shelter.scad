/*
 * Sheep shelter
 * Author: Michal Konecny
 */

// All measurements are in mm

// width, height, length
column=[200,200,2000];
higher_column=[200,200,2600];
plank=[200,20,2000];

// create all six columns first
cube(higher_column);
translate([1800,0,0])
  cube(higher_column);
translate([2*1800,0,0])
  cube(higher_column);
translate([0,1800,0])
  cube(column);
translate([1800,1800,0])
  cube(column);
translate([2*1800,1800,0])
  cube(column);

coverSide(0,0,0,0);
coverSide(0,0,0,90);
coverSide(0,2000,0,0);
coverSide(1800,2000,0,0);
coverSide(3800,0,0,90);


// cover one side with planks
module coverSide(x,y,z, angle){
  for (i = [z : plank[0] : higher_column[2]-plank[0]]){
  translate([x,y,i+plank[0]])
    rotate([0,90,angle])
      cube(plank);
  }
}
