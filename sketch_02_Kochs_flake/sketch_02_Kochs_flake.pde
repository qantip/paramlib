ArrayList<Integer> list;
Koch line;

void setup() {
  size(1200,800);
  background(0);
  list = new ArrayList<Integer>();
  list.add(0);
  list.add(1);
  list.add(0,2);
  for(int i : list){
    println(i);
  }
  stroke(255);
  line = new Koch(new PVector(50,height/2), new PVector(width-50,height/2));
}

void draw() {
  background(0);
  line.display();
  
}

void keyPressed() {
  if (key == ' ') {
    line.getNext();
  }
  if (key == 'r') {
    setup();
  }
}


class Koch{
  Koch[] next;
  PVector start, end;
  int level;
  
  Koch(PVector _start, PVector _end){
    //this.next = new Koch[4];
    this.start = _start;
    this.end = _end;
    println("S:",this.start);
    println("E:",this.end);
  }
  
  void getNext(){
    if (this.next != null){
      for(int i = 0; i < this.next.length; i++){
        this.next[i].getNext();
      }
    } else {
      this.next = new Koch[4];
      PVector vector = this.end.copy().sub(this.start);
      PVector step = vector.copy().mult(1.0/3);
      PVector point1 = this.start.copy().add(step);
      PVector move2 = vector.copy().mult(1/3).add(step.rotate(PI/3));
      PVector point2 = this.start.copy().add(move2);
      PVector point3 = this.end.copy().sub(step.rotate(-2*PI/3));
      println("-:",step);
      println("1:",point1);
      ellipse(point2.x,point2.y,5,5);

      
      this.next[0] = new Koch(this.start,point1);
      this.next[1] = new Koch(point1 ,point2);
      this.next[2] = new Koch(point2 ,point3);
      this.next[3] = new Koch(point3,this.end);
    }
  
  }
  
  void display(){
    if (this.next != null){
      for(int i = 0; i < this.next.length; i++){
        this.next[i].display();
      }
    } else {
      line(this.start.x, this.start.y, this.end.x, this.end.y);
    }
  }
}
