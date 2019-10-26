int WIDTH, HEIGHT;
float ANGLE = 20;
float SPACING = 5;
float length = 600;
String imgPath = "Mateja_Bg.jpg";
PImage img;

void settings(){
  img = loadImage(imgPath);
  WIDTH = img.width;
  HEIGHT= img.height;
  size(WIDTH,HEIGHT);
}

void setup() {
  background(0);
  background(#070033);
  float xSpacing = SPACING / sin(radians(ANGLE));
  float ySpacing = SPACING / cos(radians(ANGLE));
  print (xSpacing, ySpacing);
  float x,y,x1,y1,angleToCorner;
  // X for cycle
  y = (cos(radians(ANGLE)))>0 ? 0 : height;
  for(x = 0; x < width; x += xSpacing){
    angleToCorner = degrees(atan((height - y)/(width - x)));
    if (angleToCorner < ANGLE){
      // yMax
      x1 = x + (1/(tan(radians(ANGLE)))*(height - y));
      y1 = height;

    } else {
      // xMax
      x1 = width;
      y1 = y + tan(radians(ANGLE))*(width - x);
    }

    widthLine(x,y,x1,y1);
  }
  // Y for cycle
  x = (sin(radians(ANGLE)))>0 ? 0 : width;
  for(y = ySpacing; y < height; y += ySpacing){
    angleToCorner = degrees(atan((height - y)/(width - x)));
    if (angleToCorner < ANGLE){
      // yMax
      x1 = x + (1/(tan(radians(ANGLE)))*(height - y));
      y1 = height;
    } else {
      // xMax
      x1 = width;
      y1 = y + tan(radians(ANGLE))*(width - x);
    }

    widthLine(x,y,x1,y1);
  }
}

void widthLine(float x,float y,float x1,float y1){
  float sampling = 2;
  float wMax = SPACING * 0.6 ;
  float wMin = SPACING * 0;
  float length = sqrt( pow((x1-x),2) + pow((y1-y),2) );
  float samples = length/sampling;
  float x2,y2;
  for (float ratio = 0; ratio <= 1; ratio += 1/samples){
    x2 = x + (x1 - x)*ratio;
    y2 = y + (y1 - y)*ratio;
    color c = img.get(int(x2),int(y2));
    float w = map(brightness(c),0,255,wMin,wMax);
    noStroke();
    //colorMode(HSB);
    fill(#fffee8);
    //fill(0,0,255);
    //fill(hue(c),saturation(c)/2,255);
    //fill(0,0,255,int(map(brightness(c),0,255,0,125)));
    ellipse(x2,y2,w,w);
  }

  saveFrame(imgPath+"_result.jpg");
}

void draw(){
  noLoop();
}
