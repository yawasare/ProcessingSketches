import gifAnimation.*;

GifMaker gifExport;

CircleRing testRing1;
CircleRing testRing2;
CircleRing testRing3;
CircleRing testRing4;
CircleRing testRing5;

int count = 0;
boolean gifing = true;

void setup(){
 size(400,400);
 background(0);
 
 color[] colors = {#00FFFF , lerpColor(#00FFFF, #00FF00, .50), 
                  #00FF00, lerpColor(#00FF00, #00FFFF,.50)};
                    
 
 testRing1 = new CircleRing(200,200, 6, 100, 0, 160,  160, 0, colors[0]);
 testRing2 = new CircleRing(200,200, 5, 50,  0, 80,  00,  0, colors[1]);
 testRing3 = new CircleRing(200,200, 1,  0,  0, 90,  90,  0,colors[0]);
 testRing4 = new CircleRing(200,200, 4, 100, 0, 170, 0, 90, colors[3]);
 testRing5 = new CircleRing(200,200, 8, 150, 0, 80,  40,  90, colors[2]);
 
 gifExport = new GifMaker(this, "mandala.gif");
 gifExport.setRepeat(0);
}

void draw(){
  noStroke();
  fill(0,85);
  rect(0,0,400,400);
  testRing4.display(); 
  testRing4.change(.1);
  
  testRing1.display();
  testRing1.change(.1);
  
  testRing2.display(); 
  testRing2.change(.1);
  
  testRing3.display(); 
  testRing3.change(.1);
 
//
 // testRing5.change(.1);
  
  filter(BLUR, 2);
  
   if(gifing) {
    if( count > 23){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 43){
        gifExport.finish(); 
        gifing = false;
    }
    count++;
  }
}

class CircleRing{
 float x, y, radius, ringMinRadius, ringMaxRadius,ringSize, offsetAngle;
 int numRings;
 color c;
 Ring[] rings;

 CircleRing(float x, float y, int numRings, float radius, float minsize, 
            float maxsize, float currentsize,float offset, color c){
  this.x = x;
  this.y = y;  
  this.numRings = numRings;
  this.radius = radius;
  this.ringMinRadius = minsize;
  this.ringMaxRadius = maxsize; 
  this.offsetAngle = offset;
  this.c = c;
  this.ringSize = currentsize;
  rings = new Ring[this.numRings];
  createRings();
 } 
  
 void createRings(){
    float gap = 360/rings.length; 
    for(int i =0 ; i < rings.length; i++){
        float angle = offsetAngle + gap*i;
        float xx = x + radius*sin(radians(angle));
        float yy = y + radius*cos(radians(angle));
        rings[i] = new Ring(xx, yy, ringMinRadius, ringMaxRadius, c, ringSize, false);
    }
 } 
  
 void display(){
  for(int i =0 ; i < rings.length; i++)
      rings[i].display();  
 }

 void change(float percentage){
  for(int i =0 ; i < rings.length; i++)
      rings[i].change(percentage);  
 } 
}

class Ring {
 float minRadius;
 float maxRadius;
 color c;
 float x,y, radius;
 boolean shrinking;
 
 Ring(float xcord, float ycord, float min, float max, color c, float size, boolean shrink){
    x = xcord;
    y = ycord;
    minRadius = min;
    maxRadius = max;
    this.c = c;
    radius = size;
    shrinking = shrink;  
 }
 
 void display(){
   noFill();
   stroke(c, 80);
   strokeWeight(15);
   ellipse(x,y,radius,radius);
   stroke(c, 250);
   strokeWeight(6);
   ellipse(x,y,radius,radius);
   stroke(255,255,255,230);
   strokeWeight(4);
   ellipse(x,y,radius,radius);
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
