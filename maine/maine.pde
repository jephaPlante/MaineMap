PImage mapImage;
Table locationTable;
Table nameTable;
int rowCount;

float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;
float dataMin2 = MAX_FLOAT;
float dataMax2 = MIN_FLOAT;

void setup() {
  size(429, 577);
  frameRate(15);
  mapImage = loadImage("map.gif");
  locationTable = new Table("mainelocations.txt");
  rowCount = locationTable.getRowCount();
  
  for (int row = 0; row < rowCount; row++) {
    float value = locationTable.getFloat(row, 3);
    if (value > dataMax) {
      dataMax = value;
    }
    if (value < dataMin) {
      dataMin = value;
    }
  }
  for (int row = 0; row < rowCount; row++) {
    float value = locationTable.getFloat(row, 4);
    if (value > dataMax2) {
      dataMax2 = value;
    }
    if (value < dataMin2) {
      dataMin2 = value;
    }
  }
  PFont font = loadFont("Univers-Bold-12.vlw");
  textFont(font);
  smooth();
  noStroke();    
}


void draw() {
  background(255);
  image(mapImage, 0, 0);
  fill(0);
  text("Population VS. Median Household Income",width-249,height-77);
  text("by Maine County",width-180,height-60);
  for (int row = 0; row < rowCount; row++) {
    String abbrev = locationTable.getRowName(row);
    float x = locationTable.getFloat(abbrev, 1);
    float y = locationTable.getFloat(abbrev, 2);
    drawData(x, y, abbrev);
  }
}


void drawData(float x, float y, String abbrev) {
  int value = locationTable.getInt(abbrev, 4);  
  float percent = norm(value, dataMin2, dataMax2);
  color between = lerpColor(#2255C5, #22F766, percent,HSB); 
   float val = locationTable.getFloat(abbrev, 3);  
  fill(between);
  float mapped = map(val, dataMin, dataMax, 10, 32);
  ellipse(x, y, mapped, mapped);
  
   if (dist(x, y, mouseX, mouseY) < mapped) {//There was a +2 here
    fill(0);                               //to make it appear earlier
    //textAlign(CENTER);
    text(abbrev + " $" + value, x-45, y-mapped);//There was a -4 here
  }                                     //to move the text higher
}


