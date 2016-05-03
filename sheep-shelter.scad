/*
 * Sheep shelter
 * Author: Michal Konecny
 */

// All measurements are in cm

// shelter measurements
shelter_width=200;
shelter_length=400;

// beam
beam_width=20;
front_beam_height=240;
rear_beam_height=200;
// between first and second column
column_offset_1=280;
// between second and third column
column_offset_2=shelter_length-column_offset_1-(beam_width);
// between front and rear column
column_offset_3=shelter_width-beam_width;

// plank
plank_width=20;
plank_height=2;
plank_length=200;

// plate
plate_width = 200;
plate_length = front_beam_height;

// some help variables
roof_beam_length=sqrt(pow((front_beam_height-rear_beam_height),2)+
  pow((column_offset_3 + beam_width),2));
roof_beam_angle=asin((front_beam_height-rear_beam_height)/roof_beam_length);
echo("Roof beam length = ", roof_beam_length);
echo("Roof beam angle = ", roof_beam_angle);

// create all six columns
addColumnPair(0,beam_width,beam_width);
addColumnPair(column_offset_1,beam_width,beam_width);
addColumnPair(column_offset_1+column_offset_2,beam_width,beam_width);

// hay holder
createHayHolder(column_offset_2,80);

//roof ceiling
//addRoofCeilingBeam(beam_width,0,rear_beam_height,beam_width,
//  beam_width,ceiling_beam_length,90,0);
//addRoofCeilingBeam(beam_width,beam_width,rear_beam_height,beam_width,
//  beam_width,ceiling_beam_length,90,90);
//addRoofCeilingBeam(beam_width,column_offset,rear_beam_height,
//  beam_width,beam_width,ceiling_beam_length,90,0);
//addRoofCeilingBeam(column_offset+beam_width,column_offset,rear_beam_height,
//  beam_width,beam_width,ceiling_beam_length,90,0);
//addRoofCeilingBeam(2*column_offset+beam_width,beam_width,rear_beam_height,
//  beam_width,beam_width,ceiling_beam_length,90,90);
//addRoofCeilingBeam(column_offset+beam_width,0,rear_beam_height,beam_width,
//  beam_width,ceiling_beam_length,90,0);
//addRoofCeilingBeam(column_offset+beam_width,beam_width,rear_beam_height,
//  beam_width,beam_width,ceiling_beam_length,90,90);
addRoofCeilingBeam(beam_width,0,front_beam_height,
  beam_width,beam_width,front_beam_height,90+roof_beam_angle,90);
addRoofCeilingBeam(beam_width+column_offset_1,0,front_beam_height,
  beam_width,beam_width,front_beam_height,90+roof_beam_angle,90);
addRoofCeilingBeam(column_offset_1+column_offset_2+beam_width,0,
  front_beam_height,beam_width,beam_width,front_beam_height,90+roof_beam_angle
  ,90);

coverRoof(roof_beam_angle,60);

//sides
coverSide(0,0-plank_height,0,front_beam_height-plank_width,0,
  column_offset_1+beam_width);
coverSide(0,0,0,rear_beam_height-plank_width,90,column_offset_3+beam_width);
coverSide(0,column_offset_3+beam_width,0,rear_beam_height-plank_width,0,
column_offset_1+beam_width);
coverSide(column_offset_1,column_offset_3+beam_width,0,
  rear_beam_height-plank_width,0,column_offset_2+beam_width);
coverSide(column_offset_1+column_offset_2+beam_width+plank_height,0,0,
  rear_beam_height-plank_width,90,column_offset_3+beam_width);

// create holder for hay
module createHayHolder(hay_offset,height){
  translate([hay_offset,0,0]){
    cube([beam_width,beam_width,height]);
  }
  translate([hay_offset,column_offset_3,0]){
    cube([beam_width,beam_width,height]);
  }
  coverSide(hay_offset+beam_width,0,0,height,90,column_offset_3+beam_width);
}

// cover roof
module coverRoof(angle,roof_offset){
  roof_plank_width = 5;
  for(i = [0 : roof_offset : front_beam_height-roof_plank_width]){
    z = front_beam_height+roof_plank_width-(tan(angle)*i);
    translate([0, i+roof_plank_width, z]){
      rotate([90,90,90]){
        cube([roof_plank_width,roof_plank_width,shelter_length]);
      }
    }
  }
  for(i = [0 : plate_width : shelter_length-plate_width]){
    translate([i,0,front_beam_height+(2*roof_plank_width)]){
      rotate([-(90+angle),0,0]){
        %cube([plate_width,2,plate_length]);
      }
    }
  }
}

// cover one side with planks
module coverSide(x,y,z, height, angle, side_length){
  for (i = [z : plank_width : height-plank_width]){
  translate([x,y,i+plank_width])
    rotate([0,90,angle])
      %cube([plank_width,plank_height,side_length]);
  }
}

// add column and cut it by ceiling beam
module addColumnPair(x,width,height){
  translate([x,0,0]){
    difference(){
      union(){
        cube([width,height,front_beam_height]);
        translate([0,column_offset_3,0])
          cube([width,height,rear_beam_height]);
      }
      addRoofCeilingBeam(0+beam_width+(beam_width/2),0,
        front_beam_height+beam_width,width+beam_width,height+beam_width,
        front_beam_height,90+roof_beam_angle,90);
    }
  }
}

// create roof ceiling
module addRoofCeilingBeam(x,y,z,width,height,length,angle_y,angle_z){
  translate([x,y,z])
    rotate([0,angle_y,angle_z])
      cube([width,height,length]);
}
