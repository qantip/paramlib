int COUNT = 100;
float SIZE = 5;
int SWITCH = 1;

void setup(){
  size(800,800);
  background(255);
  noStroke();
  fill(0);
  
  PVector[] points;
  
  switch(SWITCH){
    case(0):
      points = poisson(COUNT);
      break;
    case(1):
      points = regular(int(sqrt(COUNT)),int(sqrt(COUNT)));
      break;
    default:
      points = null;
      break;
  }
  for (PVector point : points){
    ellipse(point.x,point.y,SIZE,SIZE);
  }
}


PVector[] poisson(int num){
  PVector[] result = new PVector[num]; 
  for(int i = 0; i < num; i++){
    result[i] = new PVector(random(width),random(height));
  }
  return result;
}

PVector[] regular(int xNum, int yNum){
    PVector[] result = new PVector[xNum * yNum]; 
  for(int x = 0; x < xNum; x++){
    for(int y = 0; y < yNum; y++){
      result[x*xNum+y] = new PVector(width/(xNum) * (x + 0.5), height/(yNum) * (y + 0.5));
    }
  }
  return result;
}
