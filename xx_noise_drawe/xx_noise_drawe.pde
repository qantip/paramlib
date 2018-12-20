float SCALE = 0.01;
int COUNT = 500;
float SPEED = 0.5;
float[] LIFE = {100,5000};
Particle[] particles;



void setup() {
  size(800,800);
  background(255);
  noStroke();
  colorMode(HSB,255,100,100);
  color[] palete = { color(0,100,80), color(15,80,100), color(50,70,70), color(0,0,100), color(0,0,100) };
  particles = new Particle[COUNT];
  for (int i = 0; i < COUNT; i++){
    particles[i] = new Particle( random(0,width),
                                 random(0,height),
                                 random(2,5),
                                 color(palete[int(random(palete.length))])
                               );
  }
}

void draw() {
  for (int i = 0; i < COUNT; i++){
    particles[i].update();
    particles[i].display();
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
    this.speed = SPEED;
    this.size = size;
    this.position = new PVector(x,y);
    this.velocity = new PVector(0,0);
    this.shade = col;
    this.angle = 0;
    this.life = int(random(LIFE[0],LIFE[1]));
  }
  
  void update(){
    this.off();
        
    this.life--;
    angle = map(noise(this.position.x*SCALE, this.position.y*SCALE),0,1,-PI,PI);
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
    
  void off_radius(){
    if (dist(width/2,height/2,position.x,postion.y) > width*0.8){
      this.position = new PVector(random(width), random(height));
      this.life = int(random(LIFE[0],LIFE[1]));
      this.angle = 0;  
    }
  }
  }
    
  void display(){
    fill(this.shade);
    ellipse(this.position.x, this.position.y, this.size, this.size);
  }
}
