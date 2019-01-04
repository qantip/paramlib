ArrayList<Particle> particles;
color[] COLORS = {#FF3366, #00978C, #20A4F3};
float[][] rules = {{-1, 0, 1},{1, -1, 0},{0, 1, -1}};
void setup() {
  size(600,400);
  background(#011627);
  particles = new ArrayList<Particle>();
  for (int i = 0; i < 1700; i++){
    PVector pos = new PVector(random(width),random(height));
    int col = int(random(COLORS.length));
    particles.add(new Particle(pos, col));
    noStroke();
  }
}

void draw() {
  fill(#011627,30);
  rect(0,0,width,height);
  
  for (int i = 0; i < particles.size(); i++){
    for (int j = 0; j < particles.size(); j++){
      if (i != j){
        particles.get(i).interactWith(particles.get(j));
      }
    }
    particles.get(i).applyForce();
    particles.get(i).limit();
    particles.get(i).display();
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
  PVector p;
  PVector f;
  int     c;
  float   s = 40;
  
  Particle(PVector _position, int _color){
    this.p = _position;
    this.c = _color;
    this.f = new PVector();
  }
  void interactWith(Particle particle){
    float d = this.p.dist(particle.p);
    if (d <= this.s){
      PVector force = PVector.sub(particle.p,this.p);
      force.setMag(min(5/force.mag(),5));
      force.setMag(rules[this.c][particle.c]);
      this.f.add(force);
    }
  }
  void applyForce(){
  this.p.add(this.f);
  this.f.setMag(0);
  }
  
  void limit(){
    this.p.x = max(min(this.p.x,width),0);
    this.p.y = max(min(this.p.y,height),0);
  }
  void display(){
    fill(COLORS[this.c]);
    ellipse(this.p.x,this.p.y,5,5);
  }
}
