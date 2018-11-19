int COUNT = 1500;
float ANGLE = radians(137.50776405); //Golden angle
float STEP = 0.3;
float START = 20;

void setup() {
  size(1000,1000);
  background(255);
  fill(0);
  noStroke();
  for (int i = 0; i < COUNT; i++) {
    float diameter = 0;
    if (i < COUNT/2) {
      diameter = 3 + i * 0.02;
    } else {
      diameter = 3 + (COUNT - i) * 0.02;
    }
    float angle = ANGLE * i;
    float distance = START + STEP * i;
    float x = width/2 + cos(angle)*distance;
    float y = height/2 + sin(angle)*distance;
    ellipse(x,y,diameter,diameter);
  }
}
