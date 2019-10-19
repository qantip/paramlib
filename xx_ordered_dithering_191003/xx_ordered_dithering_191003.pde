int ODtype = 1; // 0 = 2x2, 1 = 4x4, 3 = 8x8 
int [] threshold2={0,2,
                   3,1};

int [] threshold4={ 0, 8, 2,10,
                   12, 4,14, 6,
                    3,11, 1, 9,
                   15, 7,13, 5};

int [] threshold8={ 0,48,12,60, 3,51,15,63,
                  32,16,44,28,35,19,47,31,
                   8,56, 4,52,11,59, 7,55,
                  40,24,36,20,43,27,39,23,
                   2,50,14,62, 1,49,13,61,
                  34,18,46,30,33,17,45,29,
                  10,58, 6,54, 9,57, 5,53,
                  42,26,38,22,41,25,37,21};
                  
PImage output;
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

void setup(){
  int[] th = {};
  switch (ODtype){
    case 0:
      th = threshold2;
      break;
    case 1:
      th = threshold4;
      break;
    case 3:
      th = threshold8;
  }
  image(img,0,0);
  delay(1000);
  
  PImage res = orderedDithering2(img,th);
  image(res,0,0);
  res.save(imgPath+"_result.jpg");
}

/*
int [] threshold={0,2,
                  3,1};
/*                  
int mapSize=4;
int size=2;
*/

/*
int [] threshold={ 0, 8, 2,10,
                  12, 4,14, 6,
                   3,11, 1, 9,
                  15, 7,13, 5};
*/
/*                  
int mapSize=16;
int size=4;
*/

/*
int [] threshold={ 0,48,12,60, 3,51,15,63,
                  32,16,44,28,35,19,47,31,
                   8,56, 4,52,11,59, 7,55,
                  40,24,36,20,43,27,39,23,
                   2,50,14,62, 1,49,13,61,
                  34,18,46,30,33,17,45,29,
                  10,58, 6,54, 9,57, 5,53,
                  42,26,38,22,41,25,37,21};
//int mapSize=64;
//int size=8;
*/

PImage orderedDithering(PImage input,int [] threshold){
  
  int mapSize = threshold.length;
  int size = int(Math.round(Math.sqrt(mapSize)));
  
  //a new image where size is the same as input one
  input=createImage(img.width,img.height,ALPHA);
  //fetch all the pixels
  for(int j=0;j<input.height/size;j++){
    for(int i=0;i<input.width/size;i++){
      //every "mapSize" pixels per group
      for(int k=0;k<mapSize;k++){
          if(j*(size*input.width)+(i*size)+(k%size)+(k/size)*input.width<frameCount*5000){
            //determine the output color according to the elements in threshold matrix
            if(color(img.pixels[j*(size*input.width)+(i*size)+(k%size)+(k/size)*input.width])>color(threshold[k]*(256/mapSize)))
              input.pixels[j*(size*input.width)+(i*size)+(k%size)+(k/size)*input.width]=color(255);
            else
              input.pixels[j*(size*input.width)+(i*size)+(k%size)+(k/size)*input.width]=color(0);
          }
      }
    }
  }
  return input;
}

PImage orderedDithering2(PImage pic,int [] threshold){
  
  int mapSize = threshold.length;
  int size = int(Math.round(Math.sqrt(mapSize)));
  PImage result=createImage(img.width,img.height,RGB);
  result.loadPixels();
  
  for(int j=0;j<pic.height/size;j++){
    for(int i=0;i<pic.width/size;i++){
      for(int k=0;k<mapSize;k++){
       if(true){//j*(size*pic.width)+(i*size)+(k%size)+(k/size)*pic.width<frameCount*5000000){
         if(color(pic.pixels[j*(size*pic.width)+(i*size)+(k%size)+(k/size)*pic.width])>color(threshold[k]*(256/mapSize))){
           print("X");
           result.pixels[j*(size*pic.width)+(i*size)+(k%size)+(k/size)*pic.width]=color(255);
         }
         else{
           print("0");
           result.pixels[j*(size*pic.width)+(i*size)+(k%size)+(k/size)*pic.width]=color(0);
         }
       } else {
         print("*");
       }
      }
    }
  }
  result.updatePixels();
  println( result.pixels);
  return result;
}


//simple transformation from RGB to grayscale
//formula: 0.299*red + 0.587*green + 0.114*blue
void rgb2gray(){
  for(int i=0;i<img.pixels.length;i++){
    color C=img.pixels[i];
    img.pixels[i]=color(0.299*red(C)+0.587*green(C)+0.114*blue(C));
  }
}

void draw(){
}
