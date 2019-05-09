float NOISESCALE = 0.005;
float SPEED = 3.0;
ArrayList<Particle> particles; 
color[] shades = {#FC354C, #13747D, #0ABFBC, #FCF7C5};
float DEADDIST = 7;
float MAXTHICKNESS = 4;

void setup(){
  size(1200,800);
  background(0);
  noStroke();
  particles = new ArrayList<Particle>();
  noiseDetail(3);
}

void draw(){
  background(0);
  //println(particles.size());
   particles.add(randomNewParticle(particles));
  for (int i = 0; i < particles.size(); i++){
    if (particles.get(i).isDead()){
      particles.get(i).display();
      //particles.remove(i);
    } else {
      particles.get(i).update(particles,i);
      particles.get(i).display();
    }
    
  }
}

class Particle{
  
  ArrayList<PVector> positions;
  int life, age;
  boolean alive;
  color shade;
  
  Particle(PVector _pos, color _shade){
    this.positions = new ArrayList<PVector>();
    this.positions.add(_pos.copy());
    this.life = 1000;
    this.age = 0;
    this.alive = true;
    this.shade = _shade;
  }
  
  void update(ArrayList<Particle> _particles, int _i){
    int last = this.positions.size() - 1;
    PVector vector = this.positions.get(last).copy();
    float angle = noise(this.positions.get(last).x*NOISESCALE,this.positions.get(last).y*NOISESCALE)*TWO_PI;
    PVector addition = new PVector(sin(angle)*SPEED,cos(angle)*SPEED);
    
      for (int i = 0; i < _particles.size(); i++){
        if (i != _i){
          for (int j = 0; j < _particles.get(i).positions.size(); j++){
            PVector candidate = _particles.get(i).positions.get(j);
            float dist = dist(this.positions.get(last).x,this.positions.get(last).y,candidate.x,candidate.y);
            if (dist < DEADDIST){
              this.alive = false;
            }
          }
        }
      }
    
    
    vector.add(addition);
    this.positions.add(vector);
    this.age++;
  }
  
  void display(){
    if (this.positions.size() == 1){
      fill(255);
      noStroke();
      
      ellipse(this.positions.get(0).x,this.positions.get(0).y,2,2);
    } else {
      int switcher = 2;
      switch (switcher){
        case 0:
          for (int i = 0; i < this.positions.size(); i++){
            ellipse(this.positions.get(i).x,this.positions.get(i).y,2,2);
          }
          break;
        case 1:
          stroke(255);
          strokeWeight(1);
          noFill();
          
          beginShape();
          for (int i = 0; i < this.positions.size(); i++){
              curveVertex(this.positions.get(i).x,this.positions.get(i).y);
          }
          endShape();
          break;
        case 2:
          int size = this.positions.size();
          for (int i = 0; i < this.positions.size()-1; i++){
            float pressure = constrain(map(abs(i - size/2), size/2 - 20, size/2, 1, 0),0,1);
            strokeWeight(map(pressure,0,1,0.8,MAXTHICKNESS)); 
            stroke(this.shade,map(pressure,0,1,5,255));
            line(this.positions.get(i).x,this.positions.get(i).y,this.positions.get(i+1).x,this.positions.get(i+1).y);
          }
          break;
      }
    }
  }
  
  boolean isDead(){
    if ((this.age > this.life)||(!this.alive)){
      return true;
    } else {
      return false;
    }
    
  }
  
}

Particle randomNewParticle(ArrayList<Particle> _particles){
  boolean done = false;
  PVector pos = new PVector(0,0);
  while (!done){
    pos = new PVector(random(width), random(height));
    done = true;
    for (int i = 0; i < _particles.size(); i++){
      for (int j = 0; j < _particles.get(i).positions.size(); j++){
        PVector candidate = _particles.get(i).positions.get(j);
        float dist = dist(pos.x,pos.y,candidate.x,candidate.y);
        if (dist < DEADDIST){
          done = false;
        }
      }
    }
  }
  color shade = shades[floor(random(shades.length))];
  return new Particle(pos, shade);
}
