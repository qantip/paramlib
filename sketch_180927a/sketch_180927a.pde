float xPos;
float yPos;
float colorH;

void setup(){
  //size(1200,800);
  fullScreen();
  
  background(0);
  
  colorMode(HSB,256,100,100);
  xPos = random(width);
  yPos = random(height);
  colorH = 0;
}

void draw(){
  noStroke();
  colorH = (colorH + 0.2) % 256 ;
  fill(colorH,100,50);
  xPos = (width  + xPos + 10 - random(20)) % width;
  yPos = (height + yPos + 10 - random(20)) % height;
  ellipse(xPos,yPos,100,100);
}
