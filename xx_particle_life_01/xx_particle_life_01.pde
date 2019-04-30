ArrayList<Particle> particles;

//color[] COLORS = {#00A6FB, #005789, #725A01, #E2A600};
//float[][] rules = {{0, 1, -0.2, -1},{-1, 0, 1, 0.2},{0.2, -1, 0, 1}, {1, -1, 1, 0}};

color[] COLORS = {#00A6FB, #005789, #E2A600};
float[][] rules = {{-1, 1, -0.2},{-1, -0.4, 1},{-0.8, 1, -0.5}};

color BACKGROUND =  #051923;
float OPACITY = 60;
float LIMIT = 1;
int COUNT = 1500;
float RANGE = 40;
float SPEED = 0.1;

void setup() {
  size(600,600);
  background(BACKGROUND);
  particles = new ArrayList<Particle>();
  for (int i = 0; i < COUNT; i++){
    PVector pos = new PVector(random(width),random(height));
    int col = int(random(COLORS.length));
    particles.add(new Particle(pos, col));
    noStroke();
    //printRules(rules);
  }
}

void draw() {
  fill(BACKGROUND,OPACITY);
  rect(0,0,width,height);
  
  for (int i = 0; i < particles.size(); i++){
    for (int j = 0; j < particles.size(); j++){
      if (i != j){
        particles.get(i).interactWith(particles.get(j));
      }
    }
    particles.get(i).applyForce();
    particles.get(i).warp();
    particles.get(i).display();
  }
  //saveFrame("frames/frame-######.png");
}

void keyPressed() {
  if (key == ' ') {
    //rules = newRules();
    //printRules(rules);
  }
  if (key == 'r') {
    setup();
  }
}

class Particle{
  PVector p;
  PVector f;
  int     c;
  float   s = RANGE;
  
  Particle(PVector _position, int _color){
    this.p = _position;
    this.c = _color;
    this.f = new PVector();
  }
  void interactWith(Particle particle){
    //float d = this.p.dist(particle.p);
    float d = warpDist(this.p.x, this.p.y, particle.p.x, particle.p.y);
    if (d <= this.s){
      PVector force = PVector.sub(particle.p,this.p);
      force.setMag(min(SPEED/force.mag(),LIMIT));
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
  
  void warp(){
    this.p.x = (this.p.x + width) % width;
    this.p.y = (this.p.y + height) % height;
  }
  
  void display(){
    fill(COLORS[this.c]);
    ellipse(this.p.x,this.p.y,5,5);
  }
}

float warpDist(float x1, float y1, float x2, float y2){
  float dx = abs(x2 - x1);
  float dy = abs(y2 - y1);
  if (dx > 0.5*width){
    dx = width - dx;
  }
  if (dy > 0.5*height){
    dy = height - dy;
  }
  return sqrt(dx*dx + dy*dy);
}

float[][] newRules(){
  int count = COLORS.length - 1;
  float[][] r = new float[count][count];
  for (int u = 0; u <= count; u++){
    for (int v = 0; v <= count; v++){
      r[u][v] = random(-1,1);
    }
  }
  return r;
}

void printRules(float[][] rules){
  print("[ ");
  for (int u = 0; u <= 3; u++){
    print("[ ");
    for (int v = 0; v <= 3; v++){
      if (v != 0){
        print(", ");
      }
      print(rules[u][v]);
    }
    print("]");
  }
  print("]");
}
