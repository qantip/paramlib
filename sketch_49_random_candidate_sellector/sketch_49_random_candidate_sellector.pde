ArrayList<PVector> points;
int candidateNum = 100;

void setup() {
  size(1000,1000);
  background(255);
  fill(0);
  noStroke();
  points = new ArrayList<PVector>(); 
  
  for(int i = 0; i < 5000; i++) {
    PVector bestCandidate = randomPoint(width,height);
    float bestDistance = minDistance(bestCandidate,points);
    for(int c = 1; c < candidateNum; c++){
      PVector candidate = randomPoint(width,height);
      float candidateDistance = minDistance(candidate,points);
      if (candidateDistance > bestDistance){
        bestCandidate = candidate;
      }
    }
    points.add(bestCandidate);
    ellipse(bestCandidate.x,bestCandidate.y,5,5);
  }
}

PVector randomPoint(float maxU, float maxV) {
  PVector result = new PVector(random(maxU),random(maxV));
  return result;
}

float minDistance(PVector candidate, ArrayList<PVector> pointList) {
  if (pointList.size() > 0){
  float result = dist(candidate.x, candidate.y, pointList.get(0).x, pointList.get(0).y);
  for (int i = 1; i < pointList.size(); i++) {
    float distance = dist(candidate.x, candidate.y, pointList.get(i).x, pointList.get(i).y);
    if (distance < result){
      result = distance;
    }
  }
  return result;
  } else {
    return 0;
  }
}
