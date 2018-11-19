float radiusA = 250;
float radiusB = 200;
float t;
float stepA = TWO_PI/750;
float stepB = TWO_PI/117;
PVector pointA, pointB;
PVector pointOld, pointStart;
float tolerance = 5;
float protection = 100;
ArrayList<PVector> buffer;
void setup() {
  size(1000,1000);
  background(255);
  stroke(0);
  strokeWeight(0.3);
  noFill();
  t = 0;
  buffer = new ArrayList<PVector>();
  float x = width/2 + cos(t*stepA)*radiusA;
  float y = height/2 + sin(t*stepA)*radiusA;
  pointA = new PVector(x,y);
  
  float x2 = pointA.x + cos(t*stepB)*radiusB;
  float y2 = pointA.y + sin(t*stepB)*radiusB;
  pointB = new PVector(x2,y2);
  pointStart = new PVector(pointB.x,pointB.y);
  t++;
    
}

void draw() {
  pointOld = new PVector(pointB.x,pointB.y);
  
  float x = width/2 + cos(t*stepA)*radiusA;
  float y = height/2 + sin(t*stepA)*radiusA;
  pointA = new PVector(x,y);
  //ellipse(pointA.x,pointA.y,1,1);
  
  float x2 = pointA.x + cos(t*stepB)*radiusB;
  float y2 = pointA.y + sin(t*stepB)*radiusB;
  pointB = new PVector(x2,y2);

  strokeWeight(pow(30/dist(pointOld.x,pointOld.y,pointB.x,pointB.y),2));
  line(pointOld.x,pointOld.y,pointB.x,pointB.y);
  
  if (t > protection) {
    float distance = dist(pointStart.x,pointStart.y,pointB.x,pointB.y);
    if (distance <= tolerance) {
      println(distance);
      //ellipse(pointOld.x,pointOld.y,10,10);
      //ellipse(pointB.x,pointB.y,16,16);
      noLoop();
    }
  }
  
  t ++;
}
