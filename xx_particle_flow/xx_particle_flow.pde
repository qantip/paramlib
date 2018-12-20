int COUNT = 400;
float SPEED = 0.0005;
float counter;
float angle;
float distance;
float x,y;
float radius;
float hue;
float speed;
float brithness;

void setup() {
  size(800,800);
  counter = 0;
  noStroke();
  colorMode(HSB,256,100,100);
  COUNT = int(random(150,800));
}

void draw() {
  background(248);
  translate(width/2,height/2);
  ellipseMode(RADIUS);
  speed = map(mouseX,0,width,-SPEED,SPEED);
  counter += speed;
  
  for (int i = 0; i < COUNT; i++) {
    
    angle = COUNT * i;
    distance = map(sin(i*counter),-1,1,100,350);
    radius = map(sin(i*counter),-1,1,5,1);
    hue = map(sin(i*counter),-1,1,255,150);
    brithness = map(sin(i*counter),-1,1,100,40);
    fill(hue,100,brithness);
    x = cos(angle)*distance;
    y = sin(angle)*distance;
 
    ellipse(x,y,radius,radius);
    
  }
}

void keyPressed(){
  if(key == 'r'){
    setup();
  }
}
