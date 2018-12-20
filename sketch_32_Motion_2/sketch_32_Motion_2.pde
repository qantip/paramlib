Element ball; 
PVector gravity;
int counter; 

class Element {
  PVector position, lastPos;
  PVector velocity;
  PVector acceleration;
  
  Element(float posX, float posY) {
    this.position = new PVector(posX, posY);
    this.lastPos = position.copy();
    this.velocity = new PVector(0,0);
    this.acceleration = new PVector(0,0);
  }
  
  void addForce(PVector force){
    this.acceleration.add(force);
  }
  
  void update(){
    this.position.add(this.velocity);
    this.velocity.add(this.acceleration);
    this.acceleration = new PVector(0,0);
  }
  
  void display(){
    //noStroke();
    //fill(255,80);
    //ellipse(this.position.x,this.position.y,2,2);
    //vertex(this.position.x,this.position.y);
    line(this.lastPos.x,this.lastPos.y,this.position.x,this.position.y);
    lastPos = this.position.copy();
  }
}

void setup() {
  size(1000,1000);
  background(0);
  ball = new Element(width/2,height/2);
  gravity = new PVector(0.01,0.3);
  //frameRate(10);
}

void draw() {
  stroke(255,50);
  noFill();
  counter++;
  
  //background(0);
  ball.addForce(gravity);
  if ((ball.position.y > height) || (ball.position.y < 0)){
    ball.velocity.y = ball.velocity.y * (-0.8);
  }
  if ((ball.position.x > width) || (ball.position.x < 0)){
    ball.velocity.x = ball.velocity.x * (-0.8);
  }
  
  ball.update();
  ball.display();
  if (ball.velocity.mag() < 0.2){
    print("new");
    //endShape();
    ball = new Element(random(width), random(height));
    //beginShape();
  }
}

void mousePressed(){
  ball = new Element(mouseX,mouseY);
}
