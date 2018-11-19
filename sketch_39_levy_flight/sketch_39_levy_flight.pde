int STEPSIZE = 5;
int x = 500;
int y = 500;
int counter = 0;
void setup() {
  size(1000,1000);
  background(0);
  colorMode(HSB,256,100,100);
}

void draw() {
  if (counter % 500 == 0){
    x = 500;
    y = 500;
    stroke(random(256),100,100);
  }
  
  counter += 1;
  int oldx = x;
  int oldy = y;
  switch (floor(random(4))) {
    case 0:
      x += STEPSIZE;
      break;
    case 1:
      x -= STEPSIZE;
      break;
    case 2:
      y += STEPSIZE;
      break;
    case 3:
      y -= STEPSIZE;
      break;
  }
  line(oldx,oldy,x,y);
}
