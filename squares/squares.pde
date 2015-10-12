import gifAnimation.*;

GifMaker gifExport;

int count = 0;
boolean gifing = true;

SquareRing s1;

SquareRing s2;
SquareRing s3;
SquareRing s4;
SquareRing s5;

SquareRing s6;
SquareRing s7;
SquareRing s8;
SquareRing s9;

SquareRing s10;
SquareRing s11;
SquareRing s12;
SquareRing s13;

SquareRing s14;
SquareRing s15;
SquareRing s16;
SquareRing s17;

void setup(){
  smooth();
  background(0);
  size(400,400);
  
  color[] c1 = {color(150,20,180), color(15, 40, 170),color(15,150,200), color(20, 170, 80),
color(120,150,30),color(180,100,30),color(200, 20, 80)};
 
  
  s1 = new SquareRing(200, 200, 10, 250, c1, 10, false); 
  
  s2 = new SquareRing(100, 100, 10, 200, c1, 10, false); 
  s3 = new SquareRing(300, 100, 10, 200, c1, 10, false); 
  s4 = new SquareRing(100, 300, 10, 200, c1, 10, false); 
  s5 = new SquareRing(300, 300, 10, 200, c1, 10, false); 
  
  s6 = new SquareRing(100, 200, 10, 200, c1, 200, true); 
  s7 = new SquareRing(300, 200, 10, 200, c1, 200, true); 
  s8 = new SquareRing(200, 100, 10, 200, c1, 200, true); 
  s9 = new SquareRing(200, 300, 10, 200, c1, 200, true); 
  
  s10 = new SquareRing(150, 150, 10, 150, c1, 75, true); 
  s11 = new SquareRing(150, 250, 10, 150, c1, 75, false); 
  s12 = new SquareRing(250, 150, 10, 150, c1, 75, false); 
  s13 = new SquareRing(250, 250, 10, 150, c1, 75, true); 

  s14 = new SquareRing(50, 50, 10, 150, c1, 75, false); 
  s15 = new SquareRing(50, 350, 10, 150, c1, 75, true); 
  s16 = new SquareRing(350, 50, 10, 150, c1, 75, true); 
  s17 = new SquareRing(350, 350, 10, 150, c1, 75, false);
  
  gifExport = new GifMaker(this, "squares.gif");
  gifExport.setRepeat(0);
}

void draw(){
  noStroke();
  fill(0, 25);
  rect(0,0,400,400);
  
  s2.display();
  s2.change(.02);
  s3.display();
  s3.change(.02);
  s4.display();
  s4.change(.02);
  s5.display();
  s5.change(.02);
  
  s6.display();
  s6.change(.02);
  s7.display();
  s7.change(.02);
  s8.display();
  s8.change(.02);
  s9.display();
  s9.change(.02);

  s14.display();
  s14.change(.02);
  s15.display();
  s15.change(.02);
  s16.display();
  s16.change(.02);
  s17.display();
  s17.change(.02);

  s10.display();
  s10.change(.02);
  s11.display();
  s11.change(.02);
  s12.display();
  s12.change(.02);
  s13.display();
  s13.change(.02);
  
  s1.display();
  s1.change(.02);
  
  filter(BLUR, 4);
  
  if(gifing) {
    if( count % 4 == 0 && count >= 100){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 200){
        gifExport.finish(); 
        gifing = false;
    }
    count++;
  }
}

class SquareRing {
 float minlength;
 float maxlength;
 color[] colors;
 float x,y, size;
 boolean shrinking;
 int colorindex;
 
 SquareRing(float centerx, float centery, float min, float max, color[] c, float csize, boolean shrink){
    
    x = centerx;
    y = centery;
    minlength = min;
    maxlength = max;
    colors = c;
    size = csize;
    shrinking = shrink;  
    colorindex = round((colors.length-1)*((size-minlength)/(maxlength-minlength)));
 }
 
 void display(){
   noFill();
   colorindex = round((colors.length-1)*((size-minlength)/(maxlength-minlength)));
   stroke(colors[colorindex], 80);
   strokeWeight(15);
   rect(x-(size/2),y-(size/2),size,size,5);
   stroke(colors[colorindex], 250);
   strokeWeight(6);
   rect(x-(size/2),y-(size/2),size,size,5);
   stroke(255,255,255,230);
   strokeWeight(1);
   rect(x-(size/2),y-(size/2),size,size,5);
 }
 
 void change(float percentage){
   if(shrinking){
     size -= (maxlength-minlength)*percentage;
      if(size <= minlength){
        size = minlength;
        shrinking = false; 
      }
   }
   else{
     size += (maxlength-minlength)*percentage;
     if(size >= maxlength){
        size = maxlength;
        shrinking = true; 
      }
   }  
 }
}
