int CELLSIZE = 4;
int w,h;
boolean[] cells;
boolean[] rules = {0,0,1,1,0,1,0,1};
int rule;
void setup() {
  size(800,800);
  background(0);
  w = floor(width/CELLSIZE);
  h = floor(height/CELLSIZE);
  cells = new boolean[w];
}

void draw() {

}

void keyPressed() {
  if (key == ' ') {
    
  }
  if (key == 'r') {
    setup();
  }
}
