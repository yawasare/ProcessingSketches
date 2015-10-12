import gifAnimation.*;

GifMaker gifExport;

CircleRing testRing1;
CircleRing testRing2;
CircleRing testRing3;
CircleRing testRing4;
CircleRing testRing5;
CircleRing testRing6;
CircleRing testRing7;
CircleRing testRing8;

GlowCircle t2;
GlowCircle t3;

int count = 0;
boolean gifing = true;

void setup(){
 size(400,400);
 background(0);
 
 color[] colors = {#FF0000, #FF8000, #FFFF00, #40FF00, 
                    #00FFFF, #3333FF, #8000FF, #FF00FF,
                    #FF0080};
                    
                    
 t2=  new GlowCircle(72, 200,200, 40, 200, 15, 15,colors);                 
 
 testRing1 = new CircleRing(200,200, 6, 100, 0, 160,  0, 0, colors);
 testRing2 = new CircleRing(200,200, 4, 50,  0, 80,  00,  0, colors);
 testRing3 = new CircleRing(200,200, 1,  0,  0, 90,  90,  0,colors);
 testRing4 = new CircleRing(200,200, 4, 100, 0, 170, 0, 90, colors);
 testRing5 = new CircleRing(200,200, 8, 150, 0, 80,  40,  90, colors);
 testRing6 = new CircleRing(200,200, 8, 75, 0, 100,  100, 0, colors);;
 testRing7 = new CircleRing(200,200, 6, 130, 0, 120,  120,  90, colors);;
 testRing8 = new CircleRing(200,200, 4, 200, 0, 120,  120,  90, colors);;
 
 gifExport = new GifMaker(this, "mandala.gif");
 gifExport.setRepeat(0);
}

void draw(){
  noStroke();
  fill(0,85);
  rect(0,0,400,400);
  
  testRing5.change(.1);
  testRing5.display();
  
  testRing7.display();
  testRing7.change(.1);
  
  testRing4.display(); 
  testRing4.change(.1);
  
  testRing6.display();
  testRing6.change(.1);
  
  testRing1.display();
  testRing1.change(.1);
  
  testRing2.display(); 
  testRing2.change(.1);
  
  
  
  filter(BLUR, 1.5);
  
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
 color[] colors;
 color c;
 Ring[] rings;

 CircleRing(float x, float y, int numRings, float radius, float minsize, 
            float maxsize, float currentsize,float offset, color[] c){
  this.x = x;
  this.y = y;  
  this.numRings = numRings;
  this.radius = radius;
  this.ringMinRadius = minsize;
  this.ringMaxRadius = maxsize; 
  this.offsetAngle = offset;
  this.colors = c;
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
        
        float cangle = angle;
        
        while(cangle > 360)
          cangle -= 360;
          
        while(cangle < 0)
          cangle += 360;
          
        color c = colors[round((cangle/360)*(colors.length-1))];
        
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

class GlowCircle{
  GlowStick[] sticks;
  float cx, cy;
  float minr, maxr;
  float w,h;
  color[] pallette;
  
  GlowCircle(int numSticks,float x, float y, float minr, float maxr, float w, float h, color[] c){
    sticks = new GlowStick[numSticks];
    this.cx = x;
    this.cy = y;
    this.minr = minr;
    this.maxr = maxr;
    this.w = w;
    this.h = h;
    this.pallette=c;
    createSticks();
  }
  
  void createSticks(){
    float angle = 360/(sticks.length/2);  
    for(int i = 0 ; i < sticks.length; i++){
        float r  = minr + ((maxr-minr)/6)*(i%3);
        float x = cx + r*sin(radians(angle*(i)));
        float y = cy + r*cos(radians(angle*(i)));
        
        sticks[i] = new GlowStick(x,y,w,h,180 - angle*i,pallette);
        sticks[i].setMove(cx+minr*sin(radians(angle*i)), cy + minr*cos(radians(angle*i)),
                          cx+maxr*sin(radians(angle*i)), cy + maxr*cos(radians(angle*i)));
    }
  }
  
  void displaySticks(){
    for(int i = 0 ; i < sticks.length; i++){
      sticks[i].display(); 
    }
  }
  
  void moveSticks(float percentage){
    for(int i = 0 ; i < sticks.length; i++){
      sticks[i].move(percentage); 
    }
  }
  
}

class GlowStick{
 float x,y,w,h,rotation; 
 color[] colors;
 float x1,x2, y1, y2;
 int colorIndex = 0;
 
 GlowStick(float x, float y, float w, float h, float rotation, color[] colors){
  this.x = x;
  this.y = y;
  this.w = w;
  this.h = h;
  this.rotation = rotation;
  this.colors = colors;
 } 
  
 void display(){
  noStroke(); 
  color c = colors[colorIndex];
  
  pushMatrix();
  
  float angle = radians(rotation);
  translate(x,y);
  rotate(angle);
  
  fill(c, 80);
  rect(0,0,w,h,8);
  
  fill(c,200);
  rect(0,0,w/1.6,h/1.3,8);
  
  fill(color(255,180));
  rect(0,0,w/2.3,h/2,8);
  
  popMatrix(); 
 } 
 
 void setMove(float x1, float y1, float x2, float y2){
   this.x1 = x1;
   this.x2 = x2;
   this.y1 = y1;
   this.y2 = y2;
 }
 
 void move(float percentage){
   float movex = (x2 - x1)*percentage;
   float movey = (y2 - y1)*percentage;
   
   x += movex;
   y += movey;
   
   float factorx = (x2 > x1) ? 1 : -1;
   float factory = (y2 > y1) ? 1 : -1; 
    
   if(abs((x + movex)-x2) > abs(x - x2)){
    x  = x1;
   }
   
   if(abs((y + movey)-y2) > abs(y - y2)){
    y = y1;
   }
   
   updateColor();
 } 
 void updateColor(){
   
   float rot = rotation;
   
   while(rot > 360)
    rot -= 360;
    
   while(rot < 0)
    rot += 360;  
   
   println(rotation);
   colorIndex = round((rot/360)*(colors.length-1));
 }
}
