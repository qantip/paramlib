int COUNT = 5000;
float SCALE = 0.02;
Particle[] particles;

void setup() {
  size(800,800);
  background(0);
  noStroke();
  noiseDetail(2);
  particles = new Particle[COUNT];
  for(int i = 0; i < particles.length; i++){
    particles[i] = new Particle();
  }
}

void draw() {
  for(int i = 0; i < particles.length; i++){
    particles[i].move();
    particles[i].display();
  }
  
  for(int i = 0; i < particles.length; i++){
    if(particles[i].isDead()){
      particles[i] = new Particle();
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
  float x,y;
  float size = 0.1;
  int life, lifeSpan;
  
  Particle(){
    this.x = random(width);
    this.y = random(height);
    this.lifeSpan = int(random(500,800));
    this.life = 0;
  }
  
  void move(){
    float d = 0.1;
    float alfa = map( noise(this.x*SCALE, this.y*SCALE), 0, 1, 0, TWO_PI);
    float fx = cos(alfa)*d;
    float fy = sin(alfa)*d;
    this.x += fx;
    this.y += fy;
    this.life++;
  }
  
  void display(){
    ellipse(this.x,this.y,this.size,this.size);
  }
  
  boolean isDead(){
   if (this.life >= this.lifeSpan){
     return true;
   } else {
     return false;
   }
  }
}
