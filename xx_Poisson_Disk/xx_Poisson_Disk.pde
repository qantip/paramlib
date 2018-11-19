ArrayList<PVector> points;
ArrayList<Integer> active;
float col = 0;
int[] grid;
float r = 20;
float w = r/sqrt(2);
int k = 5;
int cols, rows;
float offsetX, offsetY;
boolean mode = true;

void setup() {
  size(1000,1000);
  background(255);
  fill(0);
  noStroke();
  colorMode(HSB,256,100,100);
  frameRate(100);
  
  cols = floor(width / w);
  rows = floor(height / w);
  
  grid = new int[cols * rows];
  points = new ArrayList<PVector>();
  active = new ArrayList<Integer>();
  
  for (int i = 0; i < cols * rows; i++){
    grid[i] = -1;
  }
  
  float x = width/2; //random(width);
  float y = height/2; //random(height);
  PVector point = new PVector(x,y);
  int i = floor(x / w);
  int j = floor(y / w);
  int index = points.size();
  points.add(point);
  grid[i + j * cols] = index;
  active.add(index);
  
}

void draw(){
  if (active.size() > 0){
    int rnd = floor(random(active.size()));
    PVector pt = points.get(active.get(rnd));
    
    //background(255);
    stroke(0,100,100);
    strokeWeight(4);
    point(pt.x,pt.y);
    
    boolean found = false;
    
    for(int n = 0; n < k; n++){
       boolean validResult = false;
       while (!validResult){
         float a,m;
         if(mode){
           float[] angleList = {0, PI/3, 2*PI/3, PI, 4*PI/3, 5*PI/3};
           int selector = floor(random(6));
           a = angleList[selector]+50;
           m = r*1.1;
         } else {
           a = random(TWO_PI);
           m = random(r,2*r);    
         }
        
        
        offsetX = cos(a)*m;
        offsetY = sin(a)*m;
        /*
        stroke(100,100,100,10);
        strokeWeight(8);
        point(pt.x+offsetX, pt.y+offsetY);
        */
        // check if not out of grid
        
        
        if ((pt.x+offsetX < 0) || (pt.x+offsetX > width) || (pt.y+offsetY < 0) || (pt.y+offsetY > height)){
          validResult = false;
          println("BINGO");
          //throw new Error("FCK you")1;
        } else {
          validResult = true;
        }
        
      }
      
      PVector candidate = new PVector(pt.x+offsetX,pt.y+offsetY); 
      boolean ok = true;
      int col = floor(candidate.x / w);
      int row = floor(candidate.y / w);
      for (int i = -1; i <= 1; i++){
        for (int j = -1; j <= +1; j++){
          //println(i,j);
          if ((col+i > 0) && (col+i < cols) && (row+j > 0) && (row+j < rows)){
            //int index = col+i+
            if (grid[col+i+(row+j)*cols] != -1){
              PVector neighbor = points.get(grid[col+i+(row+j)*cols]);
              //print("hum");
              float d = dist(neighbor.x, neighbor.y, candidate.x, candidate.y);
              if (d <= r){
                ok = false;
              }
            }
          }
        }
      }
      if(ok){
          stroke(0,100,100);
          strokeWeight(4);
          point(pt.x,pt.y);
          
         int index = points.size();
         points.add(candidate.copy());
         println(col,cols,row,rows,candidate);
         grid[col + row * cols] = index;
         active.add(index); 
         found = true;
         break;
      }
    }
    if(!found){
      active.remove(rnd);
    }
  }
  for(int i = 0; i < grid.length; i++){ // no way this way go trhrouh points directly
    if (grid[i] != -1){
      stroke(300,100,0);
      strokeWeight(4);
      PVector pt = points.get(grid[i]);
      point(pt.x,pt.y);
    }
  
  }
  
  
  
  //fill(col,100,100);
  //col = (col + 0.2) % 256;
  
  //PVector candidate = points.get(floor(random(points.size()))).getCandidate();
  //points.add(new PointPD(candidate.x,candidate.y));
  //points.get(points.size()-1).display();
  //println(points.size());

  
  if (points.size() > 10000){
    noLoop();
  }
}


void mousePressed(){
  setup();
}
