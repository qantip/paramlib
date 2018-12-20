
float halton(float i, float b) {
  float f = 1;
  float r = 0;
  while (i > 0) {
    f = f/b;
    r = r + f*(i % b);
    i = floor(i/b);
  }
  return r;
}

void setup() {
  size(1000,1000);
  background(255);
  fill(0);
  noStroke();
  int sum = 5000;
  for (int i = sum; i > 0; i-=5){
   float x = map(halton(i,2),0,1,+50,width-50);
   float y = map(halton(i,3),0,1,+50,height-50);
   fill(map(i,0,sum,0,250));
   ellipse(x,y,map(i,0,sum,15,10),map(i,0,sum,15,10));
  }
}

void draw() {
  
}
