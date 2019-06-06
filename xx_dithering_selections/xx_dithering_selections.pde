PVector[] points, selection;
float[] weights;

void setup() {
  size(800,800);
  background(255);
  noStroke();
  fill(0);
  points = pointGrid(100,100);
  //points = shuffle(points);
  weights = getWeights(points);
  selection = dwDithering(points,weights,25);
  display(selection);
}

void draw() {

}

PVector[] pointGrid(int xCount, int yCount){
  PVector[] results = new PVector[xCount * yCount]; 
  for (int i = 0; i < xCount; i++){
    for (int j = 0; j < yCount; j++){
      float x = width / xCount * i + (width/(2*xCount));
      float y = height / yCount * j + (height/(2*yCount)); 
      results[i * xCount + j] = new PVector(x,y);
    }
  }
  return results;
}

float[] getWeights(PVector[] points){
  int count = points.length;
  float diagonalDistance = sqrt(pow(width,2) + pow(height,2))*0.9;
  float[] results = new float[count];
  for (int i = 0; i < count; i++){
    PVector p = points[i];
    float distance = sqrt(pow(p.x,2) + pow(p.y,2));
    float weight = distance / diagonalDistance;
    results[i] = weight;
  }
  return results;
}

PVector[] randomDithering(PVector[] points, float[] weights){
  int count = points.length;
  PVector[] results = new PVector[count];
  for (int i = 0; i < count; i++){
    float rnd = random(1);
    if (rnd < weights[i]){
      results[i] = points[i];
    } else {
      results[i] = null;
    }
  }
  return results;
}

PVector[] dwDithering(PVector[] points, float[] weights, float distLimit){
  int count = points.length;
  PVector[] results = new PVector[count];
  for (int i = 0; i < count; i++){
    float error = 0;
    if (weights[i] > 0.5){
      results[i] = points[i];
      error = - 1 + weights[i];
    } else {
      results[i] = null;
      error = weights[i];
    }
    float distMass = 0;
    float weightSum = 0;
    ArrayList<Integer> neighbours = new ArrayList<Integer>();
    for (int j = i+1; j < count; j++){
      if (i != j){
        float distance = dist(points[i].x,points[i].y,points[j].x,points[j].y);
        if (distance <= distLimit){
          distMass += distance;
          weightSum += 1/distance;
          neighbours.add(j);
        }
      }
    }
    for(int index : neighbours){
     PVector p = points[index];
      float distance = dist(points[i].x,points[i].y,p.x,p.y);
      float weight = 1/distance;
      float ratio = weight / weightSum;
      float errorAddition = error * ratio;
      //println("from:",i,"to:",index,"ratio:",ratio,"distance:",distance,"mass:",distMass,"weight:",weights[index],"add:",errorAddition,"error:",error);
      weights[index] += errorAddition;
    }
  }
  return results;
}

void display(PVector[] points){
  for (PVector p : points){
    if (p != null){
      ellipse(p.x,p.y,5,5);
    }
  }
}

PVector[] shuffle(PVector[] array){
  int n = array.length;
  for(int i = 0; i < n; i++){
    int change = i + int(random(n - i));
    PVector helper = array[change];
    array[change] = array[i];
    array[i] = helper;
  }
  return array;
}

void keyPressed() {
  if (key == ' ') {
    
  }
  if (key == 'r') {
    setup();
  }
}
