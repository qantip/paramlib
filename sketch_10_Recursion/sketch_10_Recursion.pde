float RATIO = 0.3;
int MAXDEPTH = 10;

void setup() {
  size(1000,1000);
  background(255);
  fill(0);
  noStroke();
  recursion(0,0,width,height,0);
  
}

void recursion(float x, float y, float w, float h, int l) {
  if ((random(1.0) < RATIO) || (l > MAXDEPTH)) {
    fill(random(256));
    rect(x,y,x+w,y+h);
  } else {
    recursion(x,y,w/2,h/2,l+1);
    recursion(x+w/2,y,w/2,h/2,l+1);
    recursion(x,y+h/2,w/2,h/2,l+1);
    recursion(x+w/2,y+h/2,w/2,h/2,l+1);
  }
}

void draw(){
}

void mouseClicked(){
  setup();
}
