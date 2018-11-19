PVector[] points;
int POINTCOUNT = 40;
float RADIUS = 200;
float maxDistance = 10;
float STEP = 100;

void setup() {
  size(1000,1000);
  background(0);
  stroke(255);
  noFill();
  strokeWeight(0.5);
  points = new PVector[POINTCOUNT];
  for( int i = 0; i < POINTCOUNT; i++) {
    float angle = TWO_PI / POINTCOUNT * i;
    float distance = RADIUS; 
    points[i] = new PVector(width/2 + distance * cos(angle),
                            height/2 + distance * sin(angle));
  }
 beginShape();
 for (int i = 0; i < points.length; i++) {
   vertex(points[i].x,points[i].y);
   ellipse(points[i].x,points[i].y,5,5);
 }
 vertex(points[0].x,points[0].y);
 endShape();
}

void draw(){
  
  for (int i = 0; i < points.length; i++) {
    PVector force = new PVector();
    for (int j = 0; j < points.length; j++) {
      if (i != j) {
        PVector vector = new PVector(points[i].x - points[j].x,
                                     points[i].y - points[j].y);
        vector.setMag(STEP/vector.magSq());
        force.add(vector);
      }
    } 
    points[i].add(force);
  }
  
  PVector[] newPoints = PVector[0];
  for (int i = 0; i < points.length; i++) {
    float distance = dist(points[i % points.length].x,
                          points[i % points.length].y,
                          points[(i-1) % points.length].x,
                          points[(i-1) % points.length].y);
    if (distance >= maxDistance){
      points = splice(points,
                      new PVector( (points[i % points.length].x + points[(i-1) % points.length].x)/2,
                                   (points[i % points.length].y + points[(i-1) % points.length].y)/2),
                      i               
                     );
    }
  }
  
  beginShape();
  for (int i = 0; i < points.length; i++) {
    vertex(points[i].x,points[i].y);
    ellipse(points[i].x,points[i].y,5,5);
  }
  vertex(points[0].x,points[0].y);
  endShape();
}
