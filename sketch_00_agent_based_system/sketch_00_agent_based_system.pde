void setup(){
}


class Agent {
  Agent(float _x, float _y) {
    float xPos = _x;
    float yPos = _y;
    float xVel = 0;
    float yVel = 0;
    
  void update() {
    updateVelocity();
    updatePosition();
  }
  
  void updatePosition() {
    xPos += xVel;
    ypos += yVel;
  }
  
  void updateVelocity(x,y) {
    xVel += x;
    yVel += y;
  }
  
}
  

}
