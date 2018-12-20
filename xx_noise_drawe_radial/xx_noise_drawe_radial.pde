float SCALE = 0.02;
int COUNT = 5000;
float SPEED = 0.5;
float[] LIFE = {100,5000};
Particle[] particles;
float time;
boolean looping = true;



void setup() {
  size(800,800);
  background(255);
  noStroke();
  colorMode(HSB,255,100,100);
  color[] palete = { #2A5D84, #EFEEE5, #C9D6E0, #FB7A24, #FFFFFF };
  time = random(0,100);
  particles = new Particle[COUNT];
  for (int i = 0; i < COUNT; i++){
    particles[i] = new Particle( random(0,width),
                                 random(0,height),
                                 random(0.1,1),
                                 color(palete[int(random(palete.length))])
                               );
  }
}

void draw() {
  if (looping){
    for (int i = 0; i < COUNT; i++){
      particles[i].update();
      particles[i].display();
    }
    time+=0.0001;
  }
}

class Particle {
  PVector position;
  PVector velocity;
  float speed;
  float size;
  color shade;
  int life;
  float angle;
  
  Particle(float x,float y, float size, color col){
    this.speed = random(SPEED/10,SPEED);
    this.size = size;
    this.position = new PVector(x,y);
    this.velocity = new PVector(0,0);
    this.shade = col;
    this.angle = 0;
    this.life = int(random(LIFE[0],LIFE[1]));
  }
  
  void update(){
    this.off_radius();
        
    this.life--;
    angle = map(noise(this.position.x*SCALE, this.position.y*SCALE,time),0,1,-PI,PI);
    this.velocity.x = cos(angle) * speed;
    this.velocity.y = sin(angle) * speed;
    this.position.add(this.velocity);
  }
  
  void off(){
    if(this.position.x > width || this.position.x < 0 || this.position.y > height || this.position.y < 0 || this.life < 0){
      this.position = new PVector(random(width), random(height));
      this.life = int(random(LIFE[0],LIFE[1]));
      this.angle = 0;
    }
  }
   void off_radius(){
    if (dist(width/2,height/2,position.x,position.y) > width*0.4){
      while (dist(width/2,height/2,position.x,position.y) > width*0.4){
        this.position = new PVector(random(width), random(height));
      }
      this.life = int(random(LIFE[0],LIFE[1]));
      this.angle = 0;  
    }
  }
    
  void display(){
    fill(this.shade);
    ellipse(this.position.x, this.position.y, this.size, this.size);
  }
}

void keyPressed(){
  if (key == ' '){
  looping = !looping;
  }
  if (key == 'r'){
    setup();
  }
}
