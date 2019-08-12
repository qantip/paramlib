PImage img;
String imagePath = "corp.jpg";

void setup() {
  img = loadImage(imagePath);
  size(218,430);
  //image(img,0,0);
  //image(FSDither(img,2),0,0);
  //image(treshold(img,2),0,0);
  image(randomDither(img,2),0,0);
  saveFrame("latest.jpg");
  //println("done");

  
}

void draw() {

  

}

int limiter(float v, int l, int max){
   l--;
   int r = round(l * v / max) * (max / l);
   //println(v,r);
   return r;
}

int index(int _x,int _y,int _w){
  //println("index",_x,_y,_w,_y*_w+_x);
  return _y*_w+_x;
}

PImage FSDither(PImage pic,int levels){
  pic.loadPixels();
  for (int y = 0; y < pic.height; y++){
    for (int x = 0; x < pic.width; x++){
      int i = index(x,y,pic.width);
      color c = pic.pixels[i];
      
      int r = limiter(red(c),levels,255);
      int g = limiter(green(c),levels,255);
      int b = limiter(blue(c),levels,255);
      
      pic.pixels[i] = color(r,g,b);
      
      if ((x < pic.width-1) & (y < pic.height-1) & (x > 0)){
        
        float eR = red(c)   - r;
        float eG = green(c) - g;
        float eB = blue(c)  - b;
        
        float p = 7/16.0;
        i = index(x+1, y,pic.width);
        c = pic.pixels[i];
        r = round(red(c) + eR*p);
        g = round(green(c) + eG*p);
        b = round(blue(c) + eB*p);
        pic.pixels[i] = color(r,g,b);
        
        p = 3/16.0;
        i = index(x-1, y+1,pic.width);
        c = pic.pixels[i];
        r = round(red(c) + eR*p);
        g = round(green(c) + eG*p);
        b = round(blue(c) + eB*p);
        pic.pixels[i] = color(r,g,b);
        
        p = 5/16.0;
        i = index(x, y+1,pic.width);
        c = pic.pixels[i];
        r = round(red(c) + eR*p);
        g = round(green(c) + eG*p);
        b = round(blue(c) + eB*p);
        pic.pixels[i] = color(r,g,b);
        
        p = 1/16.0;
        i = index(x+1, y+1, pic.width);
        //println(pic.width,pic.height,x,y,i);
        c = pic.pixels[i];
        r = round(red(c) + eR*p);
        g = round(green(c) + eG*p);
        b = round(blue(c) + eB*p);
        pic.pixels[i] = color(r,g,b);
        
      }
    }
  }
  pic.updatePixels();
  return pic;
}
PImage randomDither(PImage pic, int levels){
  pic.loadPixels();
  for (int y = 0; y < pic.height; y++){
    for (int x = 0; x < pic.width; x++){
      int i = index(x,y,pic.width);
      color c = pic.pixels[i];
      
      float l = 255/2.0 - random(255);
      
      int r = limiter(red(c)+l,levels,255);
      int g = limiter(green(c)+l,levels,255);
      int b = limiter(blue(c)+l,levels,255);
      
      pic.pixels[i] = color(r,g,b);
    }
  }
  return pic;
}


PImage treshold(PImage pic,int levels){
  PImage result = createImage(pic.width,pic.height,RGB);
  pic.loadPixels();
  for (int x = 0; x < pic.width; x++){
    for (int y = 0; y < pic.height; y++){
      int i = y * pic.width + x;
      color c = pic.pixels[i];
      
      int r = limiter(red(c),levels,255);
      int g = limiter(green(c),levels,255);
      int b = limiter(blue(c),levels,255);
      
      result.pixels[i] = color(r,g,b);
    }
  }
  result.updatePixels();
  return result;
}



void keyPressed() {
  if (key == ' ') {
    
  }
  if (key == 'r') {
    setup();
  }
}
