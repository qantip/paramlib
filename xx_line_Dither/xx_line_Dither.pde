PImage picture;
String path = "bwimg.jpg";
float ANGLE = 45;
float DISTANCE = 5;
float LENGTH = 1000;

void setup() {
  //picture = loadImage(path);
  size(1200,800);
  background(128);
  stroke(0);
  strokeWeight(1);
  // top edge start
  float xStep = tan(ANGLE)*DISTANCE;
  float y = 0;
  for(float x = xStep; x < width; x+= xStep){
    line(x,y,x+tan(90-ANGLE)*LENGTH,y+tan(ANGLE)*LENGTH); 
  }
  // bottom edge start
  float yStep = tan(90-ANGLE) * DISTANCE;
  float x = 0;
  for(y = 0; y < height; y+= yStep){
    line(x,y,x+tan(90-ANGLE)*LENGTH,y+tan(ANGLE)*LENGTH); 
  }
}

void draw() {

}

void keyPressed() {
  if (key == ' ') {
    
  }
  if (key == 'r') {
    setup();
  }
}
