
ArrayList<Particle> particles;
float NOISESCALE = 0.008;
float STEP = 1;
int PARTICLELIFE = 200;
float PARTICLESIZE = 5;
color[] colors = { #E63946, #F1FAEE, #A8DADC, #457B9D, #1D3557 };

void setup() {
  size(800,400);
  background(0);
  noStroke();
  colorMode(HSB,255,100,100);
  fill(255);
  particles = new ArrayList<Particle>();
  noiseDetail(4);
}

void draw() {
  for(int i=0; i < 100; i++){
    particles.add(new Particle(random(width),random(height),colors[int(random(colors.length))],random(0.1,0.8)));
  }
  
  println(particles.size());
  
  for (int i=0; i < particles.size(); i++){
    if (particles.get(i).isDead()){
      particles.remove(i);
      i--;
    } else {
      particles.get(i).update();
      particles.get(i).display();
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
  float lifeSpan;
  float shift;
  color c;
  float maxSize;
  
  Particle(float _x, float _y, color _c, float _s){
    this.x = _x;
    this.y = _y;
    this.c = _c;
    this.lifeSpan = PARTICLELIFE;
    this.shift = random(0,0.2);
    this.maxSize = _s;
  }
  
  void get(){
  }
  
  void set(){
  
  }
  
  void update(){
    this.lifeSpan -= 1;
    float angle = map(noise(this.x * NOISESCALE,this.y * NOISESCALE, this.shift),0,1,0,2*PI);
    
    this.x += sin(angle)*STEP;
    this.y += cos(angle)*STEP;
  }
  
  void display(){
    fill(this.c);
    float size = ((1-abs((this.lifeSpan-(PARTICLELIFE/2)))/(PARTICLELIFE/2))*this.maxSize);
    ellipse(this.x,this.y,size,size);
  }
  
  boolean isDead(){
    if ((this.x<0) || (this.y<0) || (this.x>width) || (this.y>height) || (this.lifeSpan < 0)){
      return true;
    }
    else {
      return false;
    }
  }
}
