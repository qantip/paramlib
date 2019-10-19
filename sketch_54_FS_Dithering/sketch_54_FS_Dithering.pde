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
  int w = width;
  int h = height;
  color[][] p = new color[h][w];
  float s = 7.0/16;
  float t = 3.0/16;
  float f = 5.0/16;
  float o = 1.0/16;

  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      p[y][x] = img.pixels[y*w+x];
    }
  }


  for (int y=0; y<h; y++) {
    for (int x=0; x<w; x++) {
      color oldP = p[y][x];

      color newP = find_new_color(oldP, bwPalette);
      p[y][x] = newP;

      img.pixels[y*w+x] = p[y][x];

      float qr = red(oldP) - red(newP);
      float qg = green(oldP) - green(newP);
      float qb = blue(oldP) - blue(newP);

      if (x+1 < w) {
        float nr = (p[y][x+1] >> 16 & 0xFF) + s * qr;
        float ng = (p[y][x+1] >> 8 & 0xFF) + s * qg;
        float nb = (p[y][x+1] & 0xFF) + s * qb;
        p[y][x+1] = color(nr, ng, nb);
      }

      if (x-1>=0 && y+1<h) {
        float nr = (p[y+1][x-1] >> 16 & 0xFF) + t * qr;
        float ng = (p[y+1][x-1] >> 8 & 0xFF) + t * qg;
        float nb = (p[y+1][x-1] & 0xFF) + t * qb;
        p[y+1][x-1] = color(nr, ng, nb);
      }
      if (y+1 < h) {
        float nr = (p[y+1][x] >> 16 & 0xFF) + f * qr;
        float ng = (p[y+1][x] >> 8 & 0xFF) + f * qg;
        float nb = (p[y+1][x] & 0xFF) + f * qb;
        p[y+1][x] = color(nr, ng, nb);
      }
      if (x+1<w && y+1<h) {
        float nr = (p[y+1][x+1] >> 16 & 0xFF) + o * qr;
        float ng = (p[y+1][x+1] >> 8 & 0xFF) + o * qg;
        float nb = (p[y+1][x+1] & 0xFF) + o * qb;
        p[y+1][x+1] = color(nr, ng, nb);
      }
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

color find_new_color(color c, color[] palette) {
  int bestIndex = 0;

  PVector[] vpalette = new PVector[palette.length];
  PVector vcolor = new PVector((c >> 16 & 0xFF), (c >> 8 & 0xFF), (c & 0xFF));
  float distance = vcolor.dist(new PVector(0, 0, 0));

  for (int i=0; i<palette.length; i++) {
    vpalette[i] = new PVector((palette[i] >> 16 & 0xFF), (palette[i] >> 8 & 0xFF), (palette[i] & 0xFF));
    float d = vcolor.dist(vpalette[i]);
    if (d < distance) {
      distance = d;
      bestIndex = i;
    }
  }
  return palette[bestIndex];
}
