import gifAnimation.*;

GifMaker gifExport;

Orb[][] orbs;
Orb[][] orbs1;
Orb[][] orbs2;
Orb[][] orbs3;

float blur = 1;
float factor = .1;

void setup(){
  size(400,400); 
  background(0);
  rectMode(CENTER);
  color[] cols1 ={#FF0000, #FF7F00, #FFFF00, #00FF00};
  color[] cols2 ={#00FFFF, #0000FF, #FF007F, #7F00FF};
  color[] cols3 ={#FFFF00, #00FF00, #FF0000, #FF7F00};
  color[] cols4 ={#FF007F, #7F00FF, #00FFFF, #0000FF};
  
  color[][] palettes = {cols1, cols2, cols3, cols4};
  orbs = new Orb[20][4];
  orbs1 = new Orb[20][4];
  orbs2 = new Orb[20][4];
  orbs3 = new Orb[20][4];
  for(int i = 0; i < orbs.length; i++){
    for(int y = 0; y < orbs[i].length; y++){
      float startY= y*random(100,150) + random(40);
      float endY = startY + random(40,100);
      float ofsetX = random(10);
      
      float orby = random(startY, endY);
      float orbx = (i * 20) + ofsetX;
      
      orbs[i][y] = new Orb(orbx, orby, random(10,20), palettes[round(random(palettes.length-1))]);
      orbs[i][y].setMove(orbx, orbx, startY, endY);
      
      startY= y*random(100,150) + random(40);
      endY = startY + random(40,100);
      ofsetX = random(10);
      
      orby = random(startY, endY);
      orbx = (i * 20) + ofsetX;
      
      orbs1[i][y] = new Orb(orbx, orby, random(10,20),  palettes[round(random(palettes.length-1))]);
      orbs1[i][y].setMove(orbx, orbx, endY, startY);
      
      float startX  =  y*random(100,150) + random(40);
      float endX = startX + random(40,100);
      float ofsetY = random(10);
      
      orbx = random(startX, endX);
      orby = (i * 20) + ofsetY;
      
      orbs2[i][y] = new Orb(orbx, orby, random(10,20),  palettes[round(random(palettes.length-1))]);
      orbs2[i][y].setMove(startX, endX, orby, orby);
      
      
      startX  =  y*random(100,150) + random(40);
      endX = startX + random(40,100);
      ofsetY = random(10);
      
      orbx = random(startX, endX);
      orby = (i * 20) + ofsetY;
      
      orbs3[i][y] = new Orb(orbx, orby, random(10,20),palettes[round(random(palettes.length-1))]);
      orbs3[i][y].setMove(endX, startX, orby, orby);
    } 
  }
}

void draw(){
  noStroke();
  fill(0,75);
  rect(200,200,400,400);
  for(int i = 0; i < orbs.length; i++){
    for(int y = 0; y < orbs[i].length; y++){
      orbs[i][y].display();
      orbs[i][y].move(.05);
      
      orbs1[i][y].display();
      orbs1[i][y].move(.05);
      
      orbs2[i][y].display();
      orbs2[i][y].move(.05);
      
      orbs3[i][y].display();
      orbs3[i][y].move(.05);
    }
  }
  filter(BLUR,blur);
  blur += factor;
  if( blur > 2 || blur < 1){
    factor /= -1;
    blur += factor*2;
  }
  
}

class Orb {
  float originx, originy, x, y, r;
  color c;
  float initX, initY, finalX, finalY;
  color[] colors;
  int colorChange;
  int currentColor = 0;
   float perc = 0;
  
  Orb(float xcord, float ycord, float w, float h, color[] col){
    originx = xcord;
    originy = ycord;
    x = originx;
    y = originy;
    r = radius;
    setColors(col);
  }
  
  void display(){
    drawGlow();
    drawBody();
  }
  
  void drawGlow(){
    noStroke();
    fill(c,50);
    rect(x,y,r,r);
  }
  
  void drawBody(){
    noStroke();
    fill(255,255,255,230);
    rect(x,y,r/2.5,r/2.5);
    
    fill(c,180);
    rect(x,y,r/2,r/2);
    
    fill(255,255,255,230);
    rect(x,y,r/2.5,r/2.5);
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
    
    updateColor();
  }
  
  void setColors(color[] coll){
    colors = coll;
    c = colors[0];
  }
  
  void updateColor(){
    if(colors != null) {
      
      float deltaY = y - initY;
      float totaly = finalY - initY;
        int colorindex = round(perc*(colors.length-1));
        c =  colors[colorindex];
    }
  }
}
