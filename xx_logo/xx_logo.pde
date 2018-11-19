int POINTCOUNT = 7; 
float globalRotation;
ArrayList<Float> angle;

void setup() {
  size(500,500);
  
  globalRotation = random(TWO_PI);
  angle = new ArrayList<Float>();
  for(int i = 0; i < TWO_PI; i++){
    angle.add(i*TWO_PI/POINTCOUNT);
  }
}

void draw() {
}

void mousePressed() {
  setup();
}
