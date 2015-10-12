import gifAnimation.*;

GifMaker gifExport;

GlowStick testStick;
GlowCircle testCircle;
GlowCircle t2;
GlowCircle t3;

int count = 0;
boolean gifing = true;

void setup(){
  size(400,400);
  background(0);
  rectMode(CENTER);
  color[] pallete = { #00ffff};
  color[] p2 = {#FF00FF};
  color[] p3 = {#FF8000};
  
  
  testCircle = new GlowCircle(0, 200,200, 40, 70, 55, 100,pallete);
  t2=  new GlowCircle(26, 200,200, 40, 130, 65, 100, pallete);
  
  gifExport = new GifMaker(this, "glowsticks.gif");
  gifExport.setRepeat(0);
}

void draw(){
  fill(0,85);
  noStroke();
  rect(200,200,400,400);
  //testStick.display();
  //testStick.move(.05);
  t2.displaySticks();
  t2.moveSticks(.1);
  
  testCircle.displaySticks();
  testCircle.moveSticks(.1);
  filter(BLUR, 2);
  
  if(gifing) {
    if( count % 2== 0 && count > 80 ){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 100){
        gifExport.finish(); 
        gifing = false;
    }
    count++;
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
    float angle = 360/(sticks.length-1);  
    for(int i = 0 ; i < sticks.length; i++){
        float r  = minr + ((maxr-minr)/2)*(i%2);
        float x = cx + r*sin(radians(angle*(i+1)));
        float y = cy + r*cos(radians(angle*(i+1)));
        
        sticks[i] = new GlowStick(x,y,w,pallette);
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
 float x,y,w;
 color[] colors;
 float x1,x2, y1, y2;
 int colorIndex = 0;
 
 GlowStick(float x, float y, float w, color[] colors){
  this.x = x;
  this.y = y;
  this.w = w;
  this.colors = colors;
 } 
  
 void display(){
  color c = colors[colorIndex];
  
   noFill();
        
   stroke(c, 80);
   strokeWeight(15);
   ellipse(x,y,w, w);
   stroke(c, 250);
   strokeWeight(6);
   ellipse(x,y,w, w);
   stroke(255,255,255,230);
   strokeWeight(2);
   ellipse(x,y,w, w);
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
    float swap = x1;
    x1 = x2;
    x2 = swap;
    x = x1;
   }
   
   if(abs((y + movey)-y2) > abs(y - y2)){
    float swap1 = y1;
    y1 = y2;
    y2 = swap1;   
    y = y1;
   }
   
   updateColor();
 } 
 void updateColor(){
   float total  = dist(x1,y1,x2,y2);
   float current = dist(x,y,x2,y2);
   
   colorIndex = round((current/total)*(colors.length-1));
 }
}
