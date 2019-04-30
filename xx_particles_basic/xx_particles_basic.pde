float NOISESCALE = 0.008;
ArrayList <Particle> particles;

void setup() {
  size(1200,800);
  background(0);
  particles = new ArrayList <Particle>();
  noStroke();
  fill(255,10);
}

void draw() {
  //background(0);
  particles.add(new Particle(int(random(50,500)),new PVector(random(width),random(height))));
  
  for(int i=0; i < particles.size(); i++){
    if (particles.get(i).isAlive()){
      particles.get(i).update();
      particles.get(i).display();
    } else {
      particles.remove(i);
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    
  }
  if (key == 'r') {
    setup();
  }
}

class Particle{
  
  int age;
  int lifeSpan;
  PVector pos;
  Particle(int _lifeSpan, PVector _pos){
    this.age = 0;
    this.lifeSpan = _lifeSpan;
    this.pos = _pos;
    
  }
  
  void update(){
    PVector vector  = new PVector(1,0);
    vector.rotate(noise(this.pos.x*NOISESCALE,this.pos.y*NOISESCALE,this.age*NOISESCALE)*TWO_PI);
    this.pos.add(vector);
    this.age++;
  }
  
  void display(){
    ellipse(this.pos.x, this.pos.y, 1+age/100, 1+age/100);
  }
  
  boolean isAlive(){
    if (age <= lifeSpan){
      return true;
    }
    else {
      return false;
    }
  }
}
