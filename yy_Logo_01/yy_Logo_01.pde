int POINTCOUNT = 7;
int pointA, pointB, pointC;

void setup(){
  size(1000,1000);
  noStroke();
  frameRate(10);
  colorMode(HSB,256,100,100);
}

void draw(){
  
}

void keyPressed(){
  background(0,0,100);
}

void mousePressed(){
  fill(random(256),100,100,100);
  pointA = floor(random(0,POINTCOUNT+1));
  pointB = pointA;
  while (pointB == pointA){
    pointB = floor(random(0,POINTCOUNT+1));
  }
  while ((pointC == pointA) || (pointC == pointB)){
    pointC = floor(random(0,POINTCOUNT+1));
  }
  beginShape();
  float xA = width/2 + cos((360/POINTCOUNT)*pointA) * width/2.2;
  float yA = height/2 + sin((360/POINTCOUNT)*pointA)* width/2.2;
  vertex(xA,yA);
  
  float xB = width/2 + cos((360/POINTCOUNT)*pointB) * width/2.2;
  float yB = height/2 + sin((360/POINTCOUNT)*pointB)* width/2.2;
  vertex(xB,yB);
  
  float xC = width/2 + cos((360/POINTCOUNT)*pointC) * width/2.2;
  float yC = height/2 + sin((360/POINTCOUNT)*pointC) * width/2.2;
  vertex(xC,yC);
  
  endShape();
}
