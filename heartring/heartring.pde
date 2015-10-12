import gifAnimation.*;

GifMaker gifExport;

Ring r1;
Ring r2;
Ring r3;
Ring r4;
Ring r5;
Ring r6;

int count = 0;
boolean gifing = true;

void setup(){
  smooth();
  background(0);
  size(400,400);
  
  color[] c1 = {color(255,0,93), color(0, 255, 242),color(0, 34, 255), color(162, 0, 255), color(255,0,234)};
  
   r1 = new Ring(200, 200, 10, 250, c1, 10, false); 
   r2 = new Ring(200, 200, 10, 300, c1, 200, true);
   r3 = new Ring(200, 200, 10, 250, c1, 250, true);
   r4 = new Ring(200, 200, 10, 350, c1, 350, true);  
   r5 = new Ring(200, 200, 10, 350, c1, 50, true); 
   r6 = new Ring(200, 200, 10, 200, c1, 30, true); 
   
  gifExport = new GifMaker(this, "rings.gif");
  gifExport.setRepeat(0);
}

void draw(){
  noStroke();
  fill(0, 10);
  rect(0,0,400,400);
  r1.display();
  r1.change(.01);
  r2.display();
  r2.change(.01);
  r3.display();
  r3.change(.01);
  r4.display();
  r4.change(.01);
  r5.display();
  r5.change(.01);
  r6.display();
  r6.change(.01);
  
  if(gifing) {
    if( count % 10 == 0){
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

class Ring {
 float minRadius;
 float maxRadius;
 color[] colors;
 float x,y, radius;
 boolean shrinking;
 int colorindex;
  PShape heart;
 
 Ring(float xcord, float ycord, float min, float max, color[] c, float size, boolean shrink){
    x = xcord;
    y = ycord;
    minRadius = min;
    maxRadius = max;
    colors = c;
    radius = size;
    shrinking = shrink;  
    colorindex = round((colors.length-1)*((radius-minRadius)/(minRadius-maxRadius)));
    heart = loadShape("heart2.svg");
 }
 
 void display(){
   heart.disableStyle();
   noFill();
   colorindex = round((colors.length-1)*(radius/maxRadius));
   stroke(colors[colorindex], 80);
   strokeWeight(15);
   shape(heart,x-radius/2,y-radius/2,radius,radius);
   stroke(colors[colorindex], 250);
   strokeWeight(6);
   shape(heart,x-radius/2,y-radius/2,radius,radius);
   stroke(255,255,255,230);
   strokeWeight(3);
   shape(heart,x-radius/2,y-radius/2,radius,radius);
 }
 
 void change(float percentage){
   if(shrinking){
     radius -= (maxRadius-minRadius)*percentage;
      if(radius <= minRadius){
        radius = minRadius;
        shrinking = false; 
      }
   }
   else{
     radius += (maxRadius-minRadius)*percentage;
     if(radius >= maxRadius){
        radius = maxRadius;
        shrinking = true; 
      }
   }  
 }
}
