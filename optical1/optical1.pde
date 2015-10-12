import gifAnimation.*;

GifMaker gifExport;

int count = 0;
boolean gifing = true;

Ringer test;
Ringer test1;
Ringer test2;
Ringer test3;

void setup(){
  size(400,400);
  background(0);
  test = new Ringer(0,400,1,850,8);
  test1 = new Ringer(400,400,1,850,8);
  test2 = new Ringer(0,0,1,850,8);
  test3 = new Ringer(400,0,1,850,8);
  
  gifExport = new GifMaker(this, "optical.gif");
  gifExport.setRepeat(0);
}

void draw(){
  noStroke();
  fill(0, 125);
  rect(0,0,400,400);
  test.display();
  test.move(.1);
  
  test1.display();
  test1.move(.1);
  
  test2.display();
  test2.move(.1);
  
  test3.display();
  test3.move(.1);
  
  filter(BLUR, 1);
  
  if(gifing) {
    if( count > 9){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 19){
        gifExport.finish(); 
        gifing = false;
    }
    count++;
  }
}

class Ringer{
  int numrings;
  float x,y,r;
  float minr, maxr;
  float offset, maxoffset;
  
  Ringer(float x, float y, float minr, float maxr, int num){
    this.x=  x;
    this.y = y;
    this.r = minr;
    this.minr = minr;
    this.maxr = maxr;
    this.numrings = num;
    this.maxoffset = (maxr-minr)/numrings;
    this.offset = 0;
  }
  
  void display(){
    for(int i = numrings-1; i > -1; i--){
         noFill();
        
         stroke(color(40,190,255), 80);
         strokeWeight(15);
         ellipse(x,y, minr + (i+1)*maxoffset + offset,
                  minr + (i+1)*maxoffset + offset);
         stroke(color(40,190,255), 250);
         strokeWeight(6);
         ellipse(x,y, minr + (i+1)*maxoffset + offset,
                  minr + (i+1)*maxoffset + offset);
         stroke(255,255,255,230);
         strokeWeight(1);
         ellipse(x,y, minr + (i+1)*maxoffset + offset,
                  minr + (i+1)*maxoffset + offset);
      
    }
  }
  
  void move(float percentage){
   float length = (maxoffset)*percentage;
   if( (offset += length) > maxoffset){
     offset = 0;
   } 
  }
}
