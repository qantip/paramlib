int POINTCOUNT = 10; 
float globalRotation;
ArrayList<Float> angles;
float magnitude;
float angleWidth;
float x1,y1,x2,y2;
float col;
color color1,color2;
float thickness;

void setup() {
  size(500,500);
  magnitude = width*0.4;
  thickness = random(0.5,0.95);
  angleWidth = (PI/POINTCOUNT)*thickness;
  
  colorMode(HSB,256,100,100);
  col = random(256);
  
  color1 = color(col,100,20);
  color2 = color(((col+50)%256),60,100);
  
  
  globalRotation = random(TWO_PI);
  
  
  angles = new ArrayList<Float>();
  for(int i = 0; i < POINTCOUNT; i++){
    angles.add(i*TWO_PI/POINTCOUNT);
  }

  background(255);
  //noFill();
  //stroke(0,0,0);
  noStroke();
  
  while (angles.size() > 0){
    int selector = int(random(angles.size()));
    float angle = angles.get(selector);
    
    x1 = width/2 + cos(angle  + globalRotation - angleWidth) * magnitude;
    y1 = height/2 + sin(angle + globalRotation - angleWidth) * magnitude;
    
    x2 = width/2 + cos(angle  + globalRotation + angleWidth) * magnitude;
    y2 = height/2 + sin(angle + globalRotation + angleWidth) * magnitude;
    
    if (angles.size() != POINTCOUNT){
      vertex(x1,y1);
      vertex(x2,y2);
      endShape(CLOSE);
    }
    
    if (angles.size() != 1){
      fill(lerpColor(color1,color2,angle/TWO_PI));
      
      beginShape();
      vertex(x1,y1);
      vertex(x2,y2);
    }
    
    angles.remove(selector);
  }
  endShape();
}

void draw() {
}

void mousePressed() {
  setup();
}
