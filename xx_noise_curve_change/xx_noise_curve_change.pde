PVector[] points;
float counter = 0;
float scale = 0.05;
float radius = 400;

void setup(){
  size(1000,1000);
  smooth(4);
  background(0);
  noFill();
  stroke(255,10);
  strokeWeight(0.001);
  
  points = new PVector[500];
  for (int i = 0; i < points.length; i++){
    points[i] = new PVector(width/2  + radius*cos(TWO_PI/points.length*i),
                            height/2 + radius*sin(TWO_PI/points.length*i));
  }
  
  
}

void draw() {
  for (int i = 0; i < points.length; i++){
    float curving = i;
    PVector centerVector = new PVector(points[i].x - width/2, points[i].y - height/2);
    centerVector.setMag((noise(i*scale,counter*scale)-0.5)*(curving/100));
    points[i].add(centerVector);
  }
    
  beginShape();
  for (int i = 0; i < points.length; i++){
    curveVertex(points[i].x,points[i].y);
  }
  curveVertex(points[0].x, points[0].y);
  endShape();
  
  counter += 1; 
}

void mouseClicked() {
  noLoop();
}
