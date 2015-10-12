import gifAnimation.*;

GifMaker gifExport;


int count = 0;
boolean gifing = true;

Orb[] orbs;

void setup(){
  size(400,400);
  background(0);
  
  color[] colors = {#FF0000, #FF8000, #FFFF00, #40FF00, 
                    #00FFFF, #0000FF, #8000FF, #FF00FF,
                    #FF0080};
  
  orbs = new Orb[80];
  float angle = 360/(orbs.length/2);  
    for(int i = 0 ; i < orbs.length; i++){
       float r  =  random(300,600);
        float x = 200 + r*sin(radians(angle*(i+1)));
        float y = 200 + r*cos(radians(angle*(i+1)));
      
      float rot = angle*i;
   
       while(rot > 360)
        rot -= 360;
        
       while(rot < 0)
        rot += 360;  
      
       
       int colorIndex = round((rot/360)*(colors.length-1));
      
       orbs[i] = new Orb(200 + (r*(i%2))*sin(radians(angle*(i))),
                         200 + (r*(i%2))*sin(radians(angle*(i))),
                         45,colors[colorIndex]);
       orbs[i].setMove(200,x,200,y);
    }
  
  
  gifExport = new GifMaker(this, "glowstic.gif");
  gifExport.setRepeat(0);
}

void draw(){
  fill(0,25);
  rect(0,0,400,400);
  
  
   for(int i = 0 ; i < orbs.length; i++){
    orbs[i].display();
    orbs[i].move(.02); 
   }
  
  filter(BLUR, 2.5);
  
  if(gifing) {
   if( count % 2== 0 && count > 160 ){
     gifExport.setDelay(0);
     gifExport.addFrame();
   }
   if(count == 210){
       gifExport.finish(); 
       gifing = false;
   }
    count++;
  }
}


class Orb {
  float originx, originy, x, y, r;
  color c;
  float initX, initY, finalX, finalY;
  int colorChange;
  int currentColor = 0;
   float perc = 0;
  PShape heart;
  
  
  Orb(float xcord, float ycord, float radius, color col){
    originx = xcord;
    originy = ycord;
    x = originx-radius/2;
    y = originy-radius/2;
    r = radius;
    setColor(col);
     heart = loadShape("heart.svg");
  }
  
  void display(){
    drawGlow();
    drawBody();
  }
  
  void drawGlow(){
   heart.disableStyle();
    noStroke();
    fill(c,30);
     shape(heart, x,y,r,r);
  }
  
  void drawBody(){
    heart.disableStyle();
    noStroke();

    
    noStroke();
    fill(c,180);
    shape(heart,x+r/4,y+r/4,r/2,r/2);
    
    fill(255,255,255,200);
    shape(heart,x+r/4,y+r/4,r/2,r/2);
    //filter(BLUR, 2);
  }
  
  void setMove(float xi, float xf, float yi, float yf){
    initX = xi;
    initY = yi;
    finalX = xf;
    finalY = yf;
  }
  
  void move(float percentage){
    float deltaX = finalX - initX; 
    float deltaY = finalY - initY;
    perc += percentage;
    if(perc > 1){
      perc = 0;
    }
    
    if(deltaX > 0) {
      if((x + deltaX*percentage) >= finalX){
        x = finalX;
      }
      else{
        x += deltaX*percentage;
      }
    }
    else{
       if((x + deltaX*percentage) <= finalX){
        x = finalX;
      }
      else{
        x += deltaX*percentage;
      }
    }
    
    if(deltaY > 0) {
      if((y + deltaY*percentage) >= finalY){
        y = finalY;
      }
      else{
        y += deltaY*percentage;
      } 
    }
    else{
      if((y + deltaY*percentage) <= finalY){
        y = finalY;
      }
      else{
        y += deltaY*percentage;
      } 
      
    }
    
    
    if(y == finalY && x == finalX) {
      y = initY;
      x = initX;
    }
  }
  
  void setColor(color coll){
    c = coll;
  }
  
}
