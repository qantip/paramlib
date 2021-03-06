import controlP5.*;

ControlFrame cf;
int c = 125;

PVector[] points, selection;
float[] weights;
float DOTSIZE = 4;
int gridType = 1;      // 0 = rectangle, 1 = triangle, 2 = random, 3 = possion sampling
int mix = 1;           // 0 = kepp; 1 = shuffle
int weightType = 0;    // 0 = point distance, 1 = gradient image, 2 = playboy image, 3 = umprum image
int smoothed = 1;        // 0 = No, 1 = Yes
int randomizeType = 2; // 0 = regular; 1 = weighted; 2 = by adding value; 3 = None
int ditherType = 0;    // 0 = Distance weighted dithering, 1 = random, 2 = Threshold

void settings() {
  size(400,800);
}


void setup() {
  //cf = new ControlFrame(this, 300, 800, "Controls");
  //surface.setLocation(420,10);
  //size(800,800);
  //background(255);
  noStroke();
  fill(0);
  render();
}

  void render() {

  // CREATING GRID //////////////
  switch(gridType){
    case 0:
      points = pointGrid(int(width/(DOTSIZE*1.5)),int(height/(DOTSIZE*1.5)));
      break;
    case 1:
      points = pointDiaGrid(int(width/(DOTSIZE*1.5)),int(height/(DOTSIZE*1.5)));
      break;
    case 2:
      points = pointRandom(int(width/(DOTSIZE*1.5)*height/(DOTSIZE*1.5)));
      break;
    default:
      points = possionDisk(int(width/(DOTSIZE*1.5)*height/(DOTSIZE*1.5)),10);
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
  if(smoothed == 1){
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
    case 2:
      weights = randomAdd(weights,0.1);
      break;
    default:
      break;
  }

  // Dithering SELECTION ////////////
  switch(ditherType){
    case 0:
      selection = dwDithering(points,weights,30);
      break;
    case 1:
      selection = randomDithering(points,weights);
      break;
    default:
      selection = treshold(points,weights);
      break;
  }

  //display(selection);
  //println("done");
}

void draw() {
  background(255);
  display(selection);
}

class ControlFrame extends PApplet {

  int w, h;
  PApplet parent;
  ControlP5 cp5;

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w,h);
  }

  public void setup() {
    //surface.setLocation(10,10);
    cp5 = new ControlP5(this);
    //cp5.addButton("Choose file").plugTo(parent,"chooseFile").setPosition(10,10);
    //cp5.addButton("Save Frame").plugTo(parent, "saveFrame").setPosition(10,40);
    //cp5.addToggle("auto").plugTo(parent, "auto").setPosition(10,70);
    //cp5.addToggle("blend").plugTo(parent, "blend").setPosition(10,110);
    //cp5.addNumberbox("seed").plugTo(parent, "seed").setRange(0, 360).setValue(1).setPosition(100, 10).setSize(100,20);
    //cp5.addNumberbox("color").plugTo(parent, "c").setRange(0, 125).setValue(1).setPosition(100, 35).setSize(100,20);
    //cp5.addNumberbox("color2").plugTo(parent, "c2").setRange(0, 1000).setValue(1).setPosition(100, 60).setSize(100,20);
    //cp5.addSlider("speed").plugTo(parent, "speed").setRange(0, 0.1).setValue(0.01).setPosition(100, 260).setSize(200,20);
    cp5.addButton("Render").setPosition(10,600).plugTo(parent,"render");

    cp5.addListBox("Prohazeni")
      .setPosition(10,500)
      .addItem("Ano",1)
      .addItem("Ne",0)
      .plugTo(parent,"mix");

    /*cp5.addMultiList("Prohazeni")
      .updateLocation(10,500)
      .add(new "Ano",1)
      .add("Ne",0)
      .plugTo(parent,"mix");
    */

    cp5.addListBox("Zdroj")
      .setPosition(10,400)
      .addItem("Radialni",0)
      .addItem("Mekka mapa",1)
      .addItem("Playbody",2)
      .addItem("Umprum",3)
      .plugTo(parent,"weightType");

     cp5.addDropdownList("Smoothing")
      .setPosition(10,300)
      .addItem("Ne",0)
      .addItem("Ano",1)
      .close()
      .plugTo(parent,"smoothed");

    cp5.addDropdownList("Typ Ditheringu")
      .setPosition(10,200)
      .addItem("DWD",0)
      .addItem("RD",1)
      .addItem("TH",2)
      .close()
      .plugTo(parent,"ditherType");

    cp5.addDropdownList("Typ Mrizky")
      .setPosition(10,100)
      .addItem("ctverec",0)
      .addItem("trojuhelnik",1)
      .addItem("nahodny",2)
      .addItem("possion",3)
      .close()
      .plugTo(parent,"gridType");

    cp5.addSlider("yCount")
      .setRange(10,800)
      .setPosition(10,50);

   cp5.addSlider("Density")
      .setRange(50,500)
      .setPosition(10,10)
      .plugTo(parent, "");




  }

  void draw(){
    background(0);
  }
}

PVector[] pointGrid(int xCount, int yCount){
  PVector[] results = new PVector[xCount * yCount];
  for (int j = 0; j < yCount; j++){
    for (int i = 0; i < xCount; i++){
      float x = (width / float(xCount)) * i + (width/(2*xCount));
      float y = (height / float(yCount)) * j + (height/(2*yCount));
      results[j * xCount + i] = new PVector(x,y);
    }
  }
  return results;
}

PVector[] pointDiaGrid(int xCount, int yCount){
  println(xCount,yCount);
  PVector[] results = new PVector[xCount * yCount];
  float xSpacing = width / float(xCount);
  float ySpacing = height / float(yCount);
  for (int j = 0; j < yCount; j++){
    for (int i = 0; i < xCount; i++){
      float x = xSpacing * (i+(1.0/2));
      if (i % 2 == 0){
        float y = ySpacing * (j+(1.0/4));
        //println("-",i,j,x,y);
        results[j * xCount + i] = new PVector(x,y);
      } else {
        float y = ySpacing * (j+(3.0/4));
        results[j * xCount + i] = new PVector(x,y);
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

PVector[] dwDitheringCount(PVector[] points, float[] weights, int maxCount, float distLimit){
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

PVector[] treshold(PVector[] points, float[] weights){
  int count = points.length;
  PVector[] results = new PVector[count];
  for (int i = 0; i < count; i++){
    if (0.5 < weights[i]){
      results[i] = points[i];
    } else {
      results[i] = null;
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
  if (key == 's') {
    saveFrame("saveFrame.png");
    println("Frame Saved");
  }
  if (key == 'r') {
    setup();
  }
}
