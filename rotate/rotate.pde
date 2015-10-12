import gifAnimation.*;

GifMaker gifExport;

int count = 0;
boolean gifing = true;

 color[] c;

SpotLight TestLight;
SpotLight TestLight2;
SpotLight TestLight3;
SpotLight TestLight4;

SpotLight TestLight5;
SpotLight TestLight6;
SpotLight TestLight7;
SpotLight TestLight8;


void setup(){
  size(400,400);
  background(0);
  
  TestLight = new SpotLight(200,200,270, 150);
  TestLight.setMove(270,270+180, true);
  
  TestLight2 = new SpotLight(200,200,360, 150);
  TestLight2.setMove(270,270+180, false);
  
  TestLight3 = new SpotLight(200,200,270, 150);
  TestLight3.setMove(90,270, true);
  
  TestLight4 = new SpotLight(200,200,180, 150);
  TestLight4.setMove(90,270, false);
  
  TestLight5 = new SpotLight(200,200,200, 150);
  TestLight5.setMove(90,270, true);
  
  TestLight6 = new SpotLight(200,200,120, 150);
  TestLight6.setMove(90,270, false);
  
  TestLight7 = new SpotLight(200,200,330, 150);
  TestLight7.setMove(270,270+180, false);
  
  TestLight8 = new SpotLight(200,200,290, 150);
  TestLight8.setMove(270,270+180, false);
  
  
  color[] colors = {#FF0000, #FF8000, #FFFF00, #40FF00, 
                    #00FFFF, #0000FF, #8000FF, #FF00FF,
                    #FF0080};
  
  c = colors;
  
  gifExport = new GifMaker(this, "spotlight.gif");
  gifExport.setRepeat(0);
}

void draw(){
  noStroke();
  fill(0,20);
  rect(0,0,400,400);
  
  TestLight.display();
  TestLight.move(.05);
  
  float rot = TestLight.getRotation();
  
  if(TestLight.getRotation() > 360)
    rot -= 360;
    
  if(TestLight.getRotation() < 0)
    rot += 360;  
  
  int index = round((rot/360)*(c.length-1));
  TestLight.updateColor(c[index]);
  
  TestLight2.display();
  TestLight2.move(.05);
  
   rot = TestLight2.getRotation();
  
  if(TestLight2.getRotation() > 360)
    rot -= 360;
    
  if(TestLight2.getRotation() < 0)
    rot += 360;  
  
  index = round((rot/360)*(c.length-1));
  TestLight2.updateColor(c[index]);
  
  TestLight7.display();
  TestLight7.move(.05);
  
   rot = TestLight7.getRotation();
  
  if(TestLight7.getRotation() > 360)
    rot -= 360;
    
  if(TestLight7.getRotation() < 0)
    rot += 360;  
  
  index = round((rot/360)*(c.length-1));
  TestLight7.updateColor(c[index]);
  
  TestLight8.display();
  TestLight8.move(.05);
  
   rot = TestLight8.getRotation();
  
  if(TestLight8.getRotation() > 360)
    rot -= 360;
    
  if(TestLight8.getRotation() < 0)
    rot += 360;  
  
  index = round((rot/360)*(c.length-1));
  TestLight8.updateColor(c[index]);
  
  
  TestLight3.display();
  TestLight3.move(.05);
  
  rot = TestLight3.getRotation();
  
  index = round((rot/360)*(c.length-1));
  TestLight3.updateColor(c[index]);
  
  TestLight4.display();
  TestLight4.move(.05);
  
  rot = TestLight4.getRotation();
  
  index = round((rot/360)*(c.length-1));
  TestLight4.updateColor(c[index]);
  
  TestLight5.display();
  TestLight5.move(.05);
  
  rot = TestLight5.getRotation();
  
  index = round((rot/360)*(c.length-1));
  TestLight5.updateColor(c[index]);
  
  TestLight6.display();
  TestLight6.move(.05);
  
  rot = TestLight6.getRotation();
  
  index = round((rot/360)*(c.length-1));
  TestLight6.updateColor(c[index]);
  
  filter(BLUR, 4);
  
  
  if(gifing) {
    if( count >22 && count % 2 == 0){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 66){
        gifExport.finish(); 
        gifing = false;
    }
    count++;
  }
}

class SpotLight {
 float x, y, rotation, len;
 float rStart, rEnd;
 color c = color(255);
 boolean growing = false;
 
 SpotLight(float x, float y, float rotation, float l){
   this.x = x;
   this.y = y;
   this.rotation = rotation;
   this.len = l;
 }
 
 void setMove(float r1, float r2, boolean growing){
   this.rStart = r1;
   this.rEnd   = r2;
   this.growing = growing;
 }
 
 void display(){
    noStroke();
    
    
    pushMatrix();
    float angle = radians(rotation);
    translate(x,y);
    rotate(angle);
    
    float h = len/10;
    
    fill(c, 40);
    rect(0,0, len, h);
    fill(c, 200);
    rect(len/10,h/5, len - len/10, h/1.2);
    fill(color(255,255,255),255);
    rect(len/8,h/4.4, len - len/8, h/3.5);
    
    popMatrix();  
 } 
  
 void updateColor(color c){
   this.c = c;
 } 
 
 void move(float percentage){
   float delta  = (rEnd - rStart)*percentage;
   if(!growing){
     delta *= -1;
     if((rotation+=delta) < rStart){
       rotation = rStart; 
       growing = true;
     }
   }
   else{
      if((rotation+=delta) > rEnd){
       rotation = rEnd; 
       growing = false;
     }
   }
 }
 
 float getRotation(){
   return this.rotation;
 }
  
}
