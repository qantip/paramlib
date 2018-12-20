Element ball; 
PVector gravity;
int counter; 
ArrayList<Element> particles;
float noiseScale = 0.05;

class Element {
  PVector position, lastPos;
  PVector velocity;
  PVector acceleration;
  boolean trackHistory;
  ArrayList<PVector> history;
  
  Element(float posX, float posY) {
    this.position = new PVector(posX, posY);
    this.lastPos = position.copy();
    this.velocity = new PVector(0,0);
    this.acceleration = new PVector(0,0);
    this.trackHistory = true;
    this.history = new ArrayList<PVector>();
  }
  
  void addForce(PVector force){
    this.acceleration.add(force);
  }
  
  void slowDown(float rate){
    this.velocity = this.velocity.mult(1-rate);
  }
  
  void update(){
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
    this.acceleration = new PVector(0,0);
    if (this.trackHistory){
      this.history.add(this.position.copy());
    }
  }
  
  void display(){
    noStroke();
    fill(255,50);
    ellipse(this.position.x,this.position.y,2,2);
    //vertex(this.position.x,this.position.y);
    //line(this.lastPos.x,this.lastPos.y,this.position.x,this.position.y);
    //lastPos = this.position.copy();
  }
  
  void displayTrack(){
    stroke(255,50);
    strokeWeight(0.1);
    noFill();
    beginShape();
    for (PVector tick : history){
      curveVertex(tick.x,tick.y);
    }
    endShape();
  }
}

void setup() {
  size(1000,1000);
  smooth(4);
  background(0);
  //ball = new Element(width/2,height/2);
  gravity = new PVector(0.01,0.3);
  particles = new ArrayList<Element>();
  for(int i = 0; i < 10000; i++){
    particles.add(new Element(random(width),random(height)));
  }
  //frameRate(10);
}

void draw() {
  background(0);
   println(particles.size());
  
  for(int i = 0; i < particles.size(); i++){
    particles.get(i).update();
    float angle = noise(particles.get(i).position.x*noiseScale,particles.get(i).position.y*noiseScale)*TWO_PI;
    //float x = cos(angle);
    //float y = sin(angle);
    //PVector vector = new PVector(x,y);
    PVector vector = new PVector(0,1);
    vector.rotate(angle);
    particles.get(i).addForce(vector);
    particles.get(i).slowDown(0.1);
    particles.get(i).display();
    particles.get(i).displayTrack();
  }
}

void mousePressed(){
  ball = new Element(mouseX,mouseY);
}
