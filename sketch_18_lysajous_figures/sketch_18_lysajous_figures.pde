float x,y;
float x0,y0;
float A = 0.003;
float B = 0.004;
int STEPS = 100000;

void setup() {
  smooth(4);
  size(1000,1000);
  background(255);
  noFill();
  stroke(0);
  strokeWeight(0.2);
  beginShape();
  for (int i = 0; i < STEPS; i ++) {
    x = width/2+(width-(50+i/4000))/2*(cos(i*A));
    y = height/2+(height-(50+i/4000))/2*(sin(i*B));
    vertex(x,y);
  }
  endShape();
  
}

void draw() {
  /*
  x0 = x;
  y0 = y;
  x = width/2+width/2*cos(t*A);
  y = height/2+height/2*sin(t*B);
  t += 1;
  */
}
