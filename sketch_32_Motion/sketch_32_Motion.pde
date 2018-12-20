Element ball; 
PVector gravity;
int counter; 

class Element {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  Element(float posX, float posY) {
    this.position = new PVector(posX, posY);
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
    vertex(this.position.x,this.position.y);
  }
}

void setup() {
  size(1000,1000);
  background(0);
  ball = new Element(width/2,height/2);
  gravity = new PVector(0.1,0.3);
  //frameRate(10);
}

void draw() {
  stroke(255);
  noFill();
  if (counter%200 == 0){
    endShape();
    ball = new Element(random(width), random(height));
    beginShape();
  }
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
}

void mousePressed(){
  ball = new Element(mouseX,mouseY);
}
