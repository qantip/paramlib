// srource: https://github.com/danielepiccone/dithering_algorithms/blob/master/random/random.pde
//

int WIDTH, HEIGHT;
color BACKGROUND = #000000;
String imgPath = "gradient_src.jpg";
PImage img;
color[] bwPalette = new color[] {
  color(0, 0, 0), 
  color(255, 255, 255)
};

void settings(){
  img = loadImage(imgPath);
  img.loadPixels();
  WIDTH = img.width;
  HEIGHT= img.height;
  size(WIDTH,HEIGHT);
}

void setup() {
  background(BACKGROUND);
  for (int x = 0; x < img.width; x+=1) {
    for (int y = 0; y < img.height; y+=1) {
      color oldpixel = img.get(x, y);
      color newpixel = findClosestColor( color(brightness(oldpixel) + random(-128,128)) );      
      img.set(x, y, newpixel);  
    }
  }

  img.updatePixels();
  image(img, 0, 0);
  img.save(imgPath+"_result.jpg");
}


void draw() {

}

void keyPressed() {
  if (key == ' ') {
    
  }
  if (key == 'r') {
    setup();
  }
}

color findClosestColor(color c) {
  color r;
  // Treshold function
  if (brightness(c) < 128) {
    r = color(0);
  }
  else {
    r = color(255);
  }
  return r;
}
