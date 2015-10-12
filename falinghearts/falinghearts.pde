Heart theart;

void setup(){
  size(400,400);
  background(0);
  theart = new Heart(100,100, 40, color(20, 180,190));
  
}

void draw(){
  noStroke();
  fill(0,255);
  rect(0,0,400,400);
  theart.display();
  
}

class Heart{
  float x, y, size;
  float xi, yi, xf, yf;
  color hue; 
  PShape heart;
  
  
  Heart(float xx, float yy, float s, color c){
    x = xx; 
    y = yy;
    size= s;
    hue = c;
    heart = loadShape("heart.svg");
  }
  
  void display(){
    noStroke();
    heart.disableStyle();
    fill(hue, 70);
    shape(heart,x,y,size,size);
    fill(hue, 200);
    shape(heart, x+size/6, y + size/6, size/1.5, size/1.5);
    fill(255,255,255,220);
    shape(heart, x+size/4, y+size/4, size/2, size/2);
  }
  
  void setMove(float initx, float inity, float finalx, float finaly){
    xi = initx;
    xf = finalx;
    yi = inity;
    yf = finaly;
  }
  
  void move(float percentage){
    float deltay = yf - yi;  
    float deltax = xf - xi;
    
    if(deltay + deltay*percentage >= yf){
       y = yf; 
    }
    else {
       y += (deltay*percentage); 
    }
    
    if(deltax + deltax*percentage >= xf){
       x = xf; 
    }
    else {
       x += (deltax*percentage); 
    }
  }
  
}

class HeartLine{
  
  
}
