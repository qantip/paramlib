ArrayList<Particle> particles;

void setup(){
  size(800,800);
  background(255);
  particles = new ArrayList<Particle>();
  particles.add(new Particle(width/2, height/2));
  noStroke();
  fill(0);
}

void draw(){
  println(particles.size());
  float rad = random(height*0.4);
  float angle = random(TWO_PI);
  float x = width/2 + cos(angle) * rad;
  float y = height/2 + sin(angle) * rad;
  PVector position = new PVector(x,y);
  float minDistance = height;
  PVector closest = position.copy();
  if (particles.size() >= 1){
    for(int i = 1; i < particles.size(); i++){
      float distance = dist(position.x,position.y,particles.get(i).x,particles.get(i).y);
      if (distance < minDistance){
        closest = new PVector (particles.get(i).x, particles.get(i).y);
        minDistance = distance;
      }
    }
    PVector moveDir = position.sub(closest);
    moveDir.setMag(2);
    PVector newPoint = closest.add(moveDir);
    particles.add(new Particle(newPoint.x, newPoint.y));
    ellipse(newPoint.x,newPoint.y,2,2);
  }
}

class Particle{
  float x,y,r;
  Particle(float x,float y){
    this.x = x;
    this.y = y;
    this.r = 1;
  }
  void grow(){
    this.r += 0.1;
  }
}
