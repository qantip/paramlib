int XSTEP = 3;
int YSTEP = 5;
float STRENGTH = 400;
float NOISESCALE = 0.007;

void setup(){
  size(1000,1000);
  background(0);
  noFill();
  stroke(255);
  for(int y = 0; y <= height; y += YSTEP){
    beginShape();
    for(int x = 0; x <= width; x += XSTEP){
      float shiftedY = y + noise(x * NOISESCALE, y * NOISESCALE) * (STRENGTH/2) - (STRENGTH/2) ;
      print(shiftedY+", ");
      vertex(x,shiftedY);
    }
    endShape();
  }
}
