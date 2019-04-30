int[] COUNT = {500,500,500,500,500,500};
color BACKGROUND = #051923;
color[] colors = {#00A6FB, #005789, #E2A600, #FFFFFF, #FFDD22, #AFAFAF};
// svetle modrá. tmavě modrá, žlutá
ParticleSystem[] particles;
int counter;
float SIZE = 4;
float MINR = 10;
float MAXR = 0;
float[][] rules;
//float[][] rules = {{0,1,-1},{-1,0,1},{1,-1,0}};
//float[][] rules = {{-1,1,0},{-1, 0, 1},{1,-1,0}};

void setup() {
  counter = 0;
  size(500,500);
  background(BACKGROUND);
  noStroke();
  
  rules = new float[colors.length][colors.length];
  for (int i = 0; i < colors.length; i++){
    for (int j = 0; j < colors.length; j++){
      if (i != j){
        rules[i][j] = random(-1,1);
      } else {
        rules[i][j] = 0;
      }
    }
  }

  particles = new ParticleSystem[colors.length];
  for (int i = 0; i < particles.length; i++){
    particles[i] = new ParticleSystem(rules[i],i,colors[i],MINR,MAXR);
    for (int j = 0; j < COUNT[i]; j++){
      particles[i].addPoint(random(width),random(height));
    }
  }

}

void draw() {
  background(BACKGROUND);
  for( int i = 0; i < particles.length; i++){
    for (int j = 0; j < particles.length; j++)
    particles[i].interactWith(particles[j]);
  }
  for( int i = 0; i < particles.length; i++){
    particles[i].applyForce();
    particles[i].limit();    
    particles[i].display();
  }
  saveFrame("frames3/frame"+counter+".jpg");
  counter++;
}

void keyPressed() {
  if (key == ' ') {
    
  }
  if (key == 'r') {
    setup();
  }
}

class ParticleSystem{
  float[] rules;
  color   c;
  ArrayList<Particle> p;
  int     count;
  float   size = SIZE;
  float   minR, maxR;
  int     type;
  
  ParticleSystem( float[] _rules, int _type, color _color, float _minR, float _maxR) {
    this.rules = _rules;
    this.type = _type;
    this.c = _color;
    this.minR = _minR;
    this.maxR = _maxR;
    this.p = new ArrayList<Particle>();
  
  }
  void addPoint(float _x, float _y){
    this.p.add(new Particle(_x,_y));
  }
  
  void display(){
    for (int i = 0; i < this.p.size(); i++){
      this.p.get(i).display(this.size,this.c);
    }
  }
  void applyForce(){
     for (int i = 0; i < this.p.size(); i++){
       this.p.get(i).applyForce();
     }
  }
  
  void interactWith(ParticleSystem _ps){
    for (int i = 0; i < this.p.size(); i++){
      for (int j = 0; j < _ps.p.size(); j++){
      this.p.get(i).interactWith(_ps.p.get(j),_ps.type,this.maxR, this.minR, this.rules);
      }
    }
  }
  
    void limit(){
     for (int i = 0; i < this.p.size(); i++){
       this.p.get(i).limit();
     }
  }
}

class Particle{
  float x,y;
  float fx,fy;
  int id;
  
  Particle(float _x, float _y){
    this.x = _x;
    this.y = _y;
    this.fx = 0;
    this.fy = 0;
    this.id = uid();
  }
  
  void display(float size, color c){
    fill(c);
    ellipse(this.x, this.y, size, size);
  }
  
  void interactWith(Particle _p, int _t, float _maxr, float _minr, float[] _rules){
    if (this.id != _p.id){
      float r = dist(this.x, this.y, _p.x, _p.y);
      if (r < _maxr){
        if (r > _minr){
          // good distance
          PVector vector = new PVector(_p.x - this.x, _p.y - this.y);
          float amp = map(abs(_maxr-_minr-(r-_minr)),0,(_maxr-_minr),0.1,0);
          vector.setMag(amp*_rules[_t]); 
          this.fx += vector.x;
          this.fy += vector.y;
        } else {
          PVector vector = new PVector(_p.x - this.x, _p.y - this.y);
          float amp = map(r,0,_minr,2,0);
          vector.setMag(-pow(amp,2)); 
          this.fx += vector.x;
          this.fy += vector.y;
          // too close
        }
      }
    }
  }
  
  void applyForce(){
    this.x += this.fx;
    this.y += this.fy;
    this.fx = 0;
    this.fy = 0;
  }
  
  void limit(){
    this.x = max(min(width,this.x),0);
    this.y = max(min(height,this.y),0);
  }
   
}

int idc = 0;
int uid(){
  idc += 1;
  return idc;
  
}
