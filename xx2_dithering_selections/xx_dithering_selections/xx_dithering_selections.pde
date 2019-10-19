PVector[] points, selection;
float[] weights;
float DOTSIZE = 3;
int gridType = 1;      // 0 = rectangle, 1 = triangle, 2 = random, 3 = possion sampling
int mix = 1;           // 0 = kepp; 1 = shuffle
int weightType = 1;    // 0 = point distance, 1 = gradient image, 2 = playboy image, 3 = umprum image
int smooth = 1;        // 0 = No, 1 = Yes
int randomizeType = 0; // 0 = regular; 1 = weighted; 2 = by adding value;
int ditherType = 1;    // 0 = Distance weighted dithering, 1 = random

void setup() {
  size(800,800);
  background(255);
  noStroke();
  fill(0);
  
  // CREATING GRID //////////////
  switch(gridType){
    case 0:
      points = pointGrid(200,200);
      break;
    case 1:
      points = pointDiaGrid(200,200);
      break;
    case 2:
      points = pointRandom(100*100);
      break;
    default:
      points = possionDisk(100*100,10);
      break;
  }
  
  // SHUFFLE GRID /////////////////
  if (mix == 1){
    points = shuffle(points);
  }

  // GENERATING WEIGHTS /////////////
  switch(weightType){
    case 0:
      weights = getPointWeights(points,new PVector(0,0));
      break;
    case 1:
      weights = getImageWeights(points, loadImage("map.jpg"));
      break;
    case 2:
      weights = getImageWeights(points, loadImage("theplayboyce.jpg"));
      break;
    default:
      weights = getImageWeights(points, loadImage("umprum.jpg"));
      break;
  }
  
  // SMOOTHING WEIGHTS ////////////////
  if(smooth == 1){
    weights = smoothGraph(weights);
  }
  
  // RANDOMIZE WEIGHTS ////////////////
  switch(randomizeType){
    case 0:
      weights = randomize(weights,0.12);
      break;
    case 1:
      weights = randomizeWeighted(weights,0.25);
      break;
    default:
      weights = randomAdd(weights,0.1);
      break;
  }
  
  // Dithering SELECTION ////////////
  switch(ditherType){
    case 0:
      selection = dwDithering(points,weights,80);
      break;
    default:
      selection = randomDithering(points,weights);
      break;
  }
  
  display(selection);
  println("done");
  saveFrame("result-######.png");
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

PVector[] pointDiaGrid(int xCount, int yCount){
  println(xCount,yCount);
  PVector[] results = new PVector[xCount * yCount]; 
  float xSpacing = width / xCount;
  float ySpacing = height / xCount;
  for (int i = 0; i < xCount; i++){
    for (int j = 0; j < yCount; j++){
      float x = xSpacing * (i+(1.0/2));
      if (i % 2 == 0){
        float y = ySpacing * (j+(1.0/4)); 
        println("-",i,j,x,y);
        results[i * xCount + j] = new PVector(x,y);
      } else {
        float y = ySpacing * (j+(3.0/4));
        results[i * xCount + j] = new PVector(x,y);
      }

    }
  }
  return results;
}

PVector[] pointRandom(int count){
  PVector[] results = new PVector[count]; 
  for (int i = 0; i < count; i++){
    float x = random(width);
    float y = random(height); 
    results[i] = new PVector(x,y);
  }
  return results;
}

PVector[] possionDisk(int count, int candidateCount){
  PVector[] results = new PVector[count];
  float x = random(width);
  float y = random(height); 
  results[0] = new PVector(x,y); 
  for (int i = 1; i < count; i++){ // pro každý nový bod
    //PVector[] candidates = new PVector[candidateCount];
    x = random(width);
    y = random(height); 
    PVector bestCandidate = new PVector(x,y);
    float maxDistance = dist(results[0].x,results[0].y,bestCandidate.x,bestCandidate.y);
    for (int j = 1; j < candidateCount; j++){
      x = random(width);
      y = random(height);
      PVector candidate = new PVector(x,y);
      float minDistance = dist(x,y,results[0].x,results[0].y);
      for (int k = 1; k < i; k++){
        float distance = dist(x,y,results[k].x,results[k].y);
        if (distance < minDistance){
          minDistance = distance;
        }
      }
      if (minDistance > maxDistance){
        maxDistance = minDistance;
        bestCandidate = candidate.copy();
      }
    }
    results[i] = bestCandidate.copy();
  }
  return results;
}

float[] getPointWeights(PVector[] points, PVector center){
  int count = points.length;
  float diagonalDistance = sqrt(pow(center.x - width,2) + pow(center.y - height,2))*0.9;
  float[] results = new float[count];
  for (int i = 0; i < count; i++){
    PVector p = points[i];
    float distance = sqrt(pow(p.x,2) + pow(p.y,2));
    float weight = distance / diagonalDistance;
    results[i] = weight;
  }
  return results;
}

float[] getImageWeights(PVector[] points, PImage image){
  int count = points.length;
  image.loadPixels();
  float[] results = new float[count];
  for (int i = 0; i < count; i++){
    PVector p = points[i];
    float u = p.x / width;
    float v = p.y / height;
    int ix = round(u * image.width);
    int iy = round(v * image.height);
    color c = image.pixels[iy * image.width + ix];
    results[i] = 1 - brightness(c)/256;
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
    float weightSum = 0;
    ArrayList<Integer> neighbours = new ArrayList<Integer>();
    for (int j = i+1; j < count; j++){
      if (i != j){
        float distance = dist(points[i].x,points[i].y,points[j].x,points[j].y);
        if (distance <= distLimit){
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
      ellipse(p.x,p.y,DOTSIZE,DOTSIZE);
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

float[] randomize(float[] numbers, float ratio){
  for(int i = 0; i < numbers.length; i++){
    numbers[i] *= random(1-ratio,1+ratio);
  }
  return numbers;
}

float[] randomizeWeighted(float[] numbers, float ratio){
  for(int i = 0; i < numbers.length; i++){
    float weight = 2*(0.5-abs(numbers[i]-0.5)); 
    numbers[i] *= random(1-ratio*weight,1+ratio*weight);
  }
  return numbers;
}

float[] randomAdd(float[] numbers, float ratio){
  for(int i = 0; i < numbers.length; i++){
    numbers[i] += random(-ratio,+ratio);
  }
  return numbers;
}

float[] smoothGraph(float[] numbers){
  for(int i = 0; i < numbers.length; i++){
    numbers[i] = sin((2*constrain(numbers[i],0,1)-1)*PI/2)*0.5+0.5;
  }
  return numbers;
}


void keyPressed() {
  if (key == ' ') {
    
  }
  if (key == 'r') {
    setup();
  }
}
