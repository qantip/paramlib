void setup() {
  size(1000,1000);
  background(255);
  fill(0);
  noStroke();
  for(int i = 0; i < 5000; i++) {
    PVector point = randomPoint(width,height);
    ellipse(point.x,point.y,5,5);
  }
}

PVector randomPoint(float maxU, float maxV) {
  PVector result = new PVector(random(maxU),random(maxV));
  return result;
}
