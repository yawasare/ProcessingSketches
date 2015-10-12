import gifAnimation.*;

GifMaker gifExport;

RotatingTriangle tri1;
RotatingTriangle tri2;
RotatingTriangle tri3;
RotatingTriangle tri4;
RotatingTriangle tri5;
RotatingTriangle tri6;
RotatingTriangle tri7;
RotatingTriangle tri8;

int count = 0;
boolean gifing = true;


void setup(){
  size(400,400);
  background(0);
  tri1 = new RotatingTriangle(200,200,200, 180, #aa00ff);
  tri2 = new RotatingTriangle(200,200,200, 0, #aa00ff);
  tri3 = new RotatingTriangle(200,200,200, 90, #aa00ff);
  tri4 = new RotatingTriangle(200,200,200, 270, #aa00ff);
  tri5 = new RotatingTriangle(200,200,200, 45, #aa00ff);
  tri6 = new RotatingTriangle(200,200,200, -45, #aa00ff);
  tri7 = new RotatingTriangle(200,200,200, 135, #aa00ff);
  tri8 = new RotatingTriangle(200,200,200, -135, #aa00ff);
  
  gifExport = new GifMaker(this, "triangles.gif");
  gifExport.setRepeat(0);
  
}


void draw(){
  noStroke();
  fill(0,10);
  rect(0,0,400,400);
  
  tri3.display();
  tri4.display();
  tri5.display();
  tri6.display();
 // tri7.display();
  //tri8.display();
  //tri1.display();
  //tri2.display();
  
  tri1.move(-1);
  tri2.move(1);
  tri3.move(-1);
  tri4.move(1);
  tri5.move(1);
  tri6.move(-1);
  tri7.move(1);
  tri8.move(-1);
  
  filter(BLUR, 1.7); 
  
  if(gifing) {
    if( count >90 && count % 15 == 0){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 90+360){
        gifExport.finish(); 
        gifing = false;
    }
    count++;
  }
}

class RotatingTriangle{
 float centerX, centerY, sideLength;
 float rotation;
 color c; 
 
 
 RotatingTriangle(float x, float y, float len, float rotation,color c){
  this.centerX = x;
  this.centerY = y;
  this.sideLength = len;
  this.c = c;
  this.rotation = rotation;
 }
  
  
 void display(){
   noFill();
   stroke(c);
   
   pushMatrix();
   float angle = radians(rotation);
   translate(centerX,centerY);
   rotate(angle);
   
   stroke(c, 80);
   strokeWeight(15);
   triangle(-sideLength/1.6, -sideLength/1.6, 
             sideLength/1.6, -sideLength/1.6,
             0, sideLength/2); 
   
   stroke(c, 250);
   strokeWeight(6);
   triangle(-sideLength/1.6, -sideLength/1.6, 
             sideLength/1.6, -sideLength/1.6,
             0, sideLength/2); 
             
   stroke(255,255,255,230);          
   strokeWeight(3);
   triangle(-sideLength/1.6, -sideLength/1.6, 
         sideLength/1.6, -sideLength/1.6,
         0, sideLength/2); 
             
   popMatrix();   
             
 }

 void move(float angle){
    float rot = radians(angle);
    if(rotation + rot > 360)
      this.rotation = (rotation + rot)-360;
    else  
      this.rotation +=(angle);
 }
}
