import gifAnimation.*;

GifMaker gifExport;

MovingCircle top;
MovingCircle left;
MovingCircle right;

int count = 0;
boolean gifing = true;

void setup(){
 size(400,400);
 background(0);
 color[] colors = {#FA5858,#FE9A2E,#F7FE2E,#9AFE2E,#2EFEF7,#2E2EFE,#9A2EFE};
 
 top = new MovingCircle(200,275, 100,125,30, colors);
 left = new MovingCircle(100,125,300,125,30, colors);
 right = new MovingCircle(300,125,200,275,30, colors); 
 
 gifExport = new GifMaker(this, "triagle.gif");
 gifExport.setRepeat(0);
 
}

void draw(){
 noStroke();
 fill(0,5);  
 rect(0,0,400,400);
 
  
 top.display();
 left.display();
 right.display();
 
 top.move(.02);
 left.move(.02);
 right.move(.02); 
 
 filter(BLUR, 2.5);
}

class MovingCircle{
 float xi, yi, xf, yf, y ,x;
 float radius;
 color[] colors; 
 int colorIndex=0; 
  
 MovingCircle(float x1, float y1, float x2, float y2, float radius, color[] colors){
  this.xi = x1;
  this.yi = y1;
  this.xf = x2;
  this.yf = y2;
  this.radius = radius;
  this.colors = colors;
  this.x = xi;
  this.y = yi;
 }
 
 void display(){
   color c = colors[colorIndex];
  
   noStroke();
        
   fill(c, 80);
   ellipse(x,y,radius, radius);
   fill(c, 250);
   ellipse(x,y,radius/2, radius/2);
   fill(255,255,255,230);
   ellipse(x,y,radius/2.5, radius/2.5); 
 }
 
 void move(float percentage){
   float deltax = xf - xi;
   float deltay = yf - yi;
  
   float movex = deltax*percentage;
   float movey = deltay*percentage;
  
   boolean resetx = false;
   boolean resety = false;
   
   if(deltay > 0){
      if((y += movey) >= yf){
         y = yf;
         resety = true;
      }   
   }
   else if(deltay < 0){
      if((y += movey) <= yf){
         y = yf;
         resety = true;
      }  
   }
   else
     resety = true;
   
  if(deltax > 0){
      if((x += movex) >= xf){
         x = xf;
         resetx = true;
      }   
   }
   else if(deltax < 0){
      if((x += movex) <= xf){
         x = xf;
         resetx = true;
      }  
   }
   else 
     resetx = true;
   
   if(resety && resetx)
      reset();
      
   updateColors();   
 } 
 
 void reset(){
   x = xi;
   y = yi;
 }
 
 void updateColors(){
   float deltax = xf - xi;
   float deltay = yf - yi;
   
   if(abs(deltax) > abs(deltay)){
      colorIndex =  round((abs(x-xf)/abs(deltax))*(colors.length - 1));
   }
   else{
     colorIndex  =  round((abs(y-yf)/abs(deltay))*(colors.length - 1));
   } 
 }
}
