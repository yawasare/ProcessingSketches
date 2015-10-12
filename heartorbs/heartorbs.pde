import gifAnimation.*;

GifMaker gifExport;

Orb o;
Orb[][] orbs;
Orb[][] orbs2;

int count = 0;
boolean gifing = true;

void setup(){
  size(400,400);
 // o = new Orb(200,0,30,color(60,180,200));  
 // o.setMove(o.x,o.x,o.y,400);
  color[] cols = {color(230, 100, 250)};
  color[] cols1 ={ color(255, 100, 200)};
  color[] cols2 ={color(140, 30, 180),color(230, 100, 150), color(255, 20, 40), color(240, 20, 20)};
  color[] cols3 ={color(50, 25, 255), color(230, 100, 150), color(80, 200, 230),color(140, 30, 180)};
  
  color[][] ccs = {cols,cols1,cols2, cols3}; 
  orbs = new Orb[25][4];
  orbs2 = new Orb[25][4];
  
  for(int i = 0; i < orbs.length; i++){
    for(int y = 0; y < orbs[i].length; y++){
      float negY = 200;
      float overY = random(-300,300) + negY;
      float overX = random(-300,300) + 200 ;
      float ofsetX = random(5);
      
      float orby = 200;
      float orbx = 200;
      
      orbs[i][y] = new Orb(orbx, orby, random(15,60), cols);
      orbs[i][y].setMove(orbx, overX, negY, overY);
      
      negY = 200;
      overY = random(-300,300) + negY;
      overX = random(-300,300) + 200 ;
      ofsetX = random(5);
      
      orby = 200;
      orbx = 200;
      
      orbs2[i][y] = new Orb((orbx + overX)/2, (orby + overY)/2, random(15,60), cols1);
      orbs2[i][y].setMove(orbx, overX, negY, overY);
    } 
  }
  
  gifExport = new GifMaker(this, "falling2.gif");
  gifExport.setRepeat(0);
}

void draw(){
  noStroke();
  fill(0,10);
  rect(0,0,400,400);
  for(int i = 0; i < orbs.length; i++){
    for(int y = 0; y < orbs[i].length; y++){
      orbs2[i][y].display();
      orbs2[i][y].move(.01);
      
      orbs[i][y].display();
      orbs[i][y].move(.01);
      
    }
  }
  
  filter(BLUR, 1.5);
  
   if(gifing) {
    if( count % 5 == 0 && count > 200){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 300){
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
  color[] colors;
  int colorChange;
  int currentColor = 0;
  PShape heart;
  float perc = 0;
  
  Orb(float xcord, float ycord, float radius, color[] col){
    originx = xcord;
    originy = ycord;
    x = originx;
    y = originy;
    r = radius;
    setColors(col);
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
    fill(c,180);
    shape(heart,x+r/4,y+r/4,r/2,r/2);
    
    fill(255,255,255,230);
    shape(heart,x+r/4,y+r/4,r/2.5,r/2.5);
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
