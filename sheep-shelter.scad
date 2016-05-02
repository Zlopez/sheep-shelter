/*
 * Sheep shelter
 * Author: Michal Konecny
 */

// All measurements are in mm

// beam
beam_width=200;
front_beam_height=2600;
rear_beam_height=2000;
column_offset=1800;
ceiling_beam_length=column_offset-beam_width;

// plank
plank_width=200;
plank_height=20;
plank_length=2000;


// create all six columns first
cube([beam_width,beam_width,front_beam_height]);
translate([column_offset,0,0])
  cube([beam_width,beam_width,front_beam_height]);
translate([2*column_offset,0,0])
  cube([beam_width,beam_width,front_beam_height]);
translate([0,column_offset,0])
  cube([beam_width,beam_width,rear_beam_height]);
translate([column_offset,column_offset,0])
  cube([beam_width,beam_width,rear_beam_height]);
translate([2*column_offset,column_offset,0])
  cube([beam_width,beam_width,rear_beam_height]);

//roof
addRoofCeilingBeam(beam_width,0,rear_beam_height,beam_width,
  beam_width,ceiling_beam_length,0);
addRoofCeilingBeam(beam_width,beam_width,rear_beam_height,beam_width,
  beam_width,ceiling_beam_length,90);
addRoofCeilingBeam(beam_width,column_offset,rear_beam_height,
  beam_width,beam_width,ceiling_beam_length,0);
addRoofCeilingBeam(column_offset+beam_width,column_offset,rear_beam_height,
  beam_width,beam_width,ceiling_beam_length,0);
addRoofCeilingBeam(2*column_offset+beam_width,beam_width,rear_beam_height,
  beam_width,beam_width,ceiling_beam_length,90);
addRoofCeilingBeam(column_offset+beam_width,0,rear_beam_height,beam_width,
  beam_width,ceiling_beam_length,0);

//sides
coverSide(0,0-plank_height,0,0);
coverSide(0,0,0,90);
coverSide(0,column_offset+beam_width,0,0);
coverSide(column_offset,column_offset+beam_width,0,0);
coverSide(2*column_offset+beam_width+plank_height,0,0,90);


// cover one side with planks
module coverSide(x,y,z, angle){
  for (i = [z : plank_width : front_beam_height-plank_width]){
  translate([x,y,i+plank_width])
    rotate([0,90,angle])
      cube([plank_width,plank_height,plank_length]);
  }
}

// create roof ceiling
module addRoofCeilingBeam(x,y,z,width,height,length,angle){
  translate([x,y,z])
    rotate([0,90,angle])
      cube([width,height,length]);
}
