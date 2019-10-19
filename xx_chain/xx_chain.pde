Spring2D s1, s2, s3, s4;
Spring2D[] s;

float gravity = 1;
float mass = 2;

void setup() {
  size(1200, 800);
  fill(255, 126);
  // Inputs: x, y, mass, gravity
  s1 = new Spring2D(0.0, width/2, mass, gravity);
  s2 = new Spring2D(0.0, width/2, mass, gravity);
  s3 = new Spring2D(0.0, width/2, mass, gravity);
  s4 = new Spring2D(0.0, width/2, mass, gravity);
  s = new Spring2D[100];
  for( int i = 0; i < s.length; i++ ){
    s[i] = new Spring2D(0.0, width/2, mass, gravity);
  }
}

void draw() {
  background(0);
  s[0].update(mouseX,mouseY);
  s[0].display(mouseX,mouseY);
  for (int i = 1; i < s.length-1; i++){
    s[i].update(s[i-1].x,s[i-1].y);
    s[i].update(s[i+1].x,s[i+1].y);
    s[i].display(s[i-1].x,s[i-1].y);
  }
  s[s.length-1].update(s[s.length-2].x,s[s.length-2].y);
  s[s.length-1].update(width/2,height/2);
  s[s.length-1].display(s[s.length-2].x,s[s.length-2].y);
  
  s1.update(mouseX, mouseY);
  s1.update(s2.x, s2.y);
  s1.display(mouseX, mouseY);
  s2.update(s1.x, s1.y);
  s2.update(s3.x,s3.y);
  s2.display(s1.x, s1.y);
  s3.update(s2.x, s2.y);
  s3.update(s4.x,s4.y);
  s3.display(s2.x, s2.y);
  s4.update(width/2, height/2);
  s4.display(s3.x,s3.y);
}

class Spring2D {
  float vx, vy; // The x- and y-axis velocities
  float x, y; // The x- and y-coordinates
  float gravity;
  float mass;
  float radius = 3;
  float stiffness = 1.2;
  float damping = 0.6;
  
  Spring2D(float xpos, float ypos, float m, float g) {
    x = xpos;
    y = ypos;
    mass = m;
    gravity = g;
  }
  
  void update(float targetX, float targetY) {
    float forceX = (targetX - x) * stiffness;
    float ax = forceX / mass;
    vx = damping * (vx + ax);
    x += vx;
    float forceY = (targetY - y) * stiffness;
    forceY += gravity;
    float ay = forceY / mass;
    vy = damping * (vy + ay);
    y += vy;
  }
  
  void display(float nx, float ny) {
    noStroke();
    ellipse(x, y, radius*2, radius*2);
    stroke(255);
    line(x, y, nx, ny);
  }
}
