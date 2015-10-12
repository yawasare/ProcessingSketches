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
  color[] colors = {#FF0000, #FF8000, #FFFF00, #40FF00, 
                    #00FFFF, #3333FF, #8000FF, #FF00FF,
                    #FF0080};
  
  color[] c = colors;
  
  testCircle = new GlowCircle(36, 200,200, 20, 70, 15,15,c);
  t2=  new GlowCircle(72, 200,200, 50, 120, 15, 15,c);
  t3 =  new GlowCircle(72, 200,200, 100, 150, 15, 15,c);
  
  gifExport = new GifMaker(this, "glowsticks10.gif");
  gifExport.setRepeat(0);
}

void draw(){
  fill(0,45);
  rect(200,200,400,400);
  //testStick.display();
  //testStick.move(.05);
  t3.displaySticks();
  t3.moveSticks(.1);
  
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
  
  fill(color(255,230));
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
