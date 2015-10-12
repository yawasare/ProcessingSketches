import gifAnimation.*;

GifMaker gifExport;

Tri testTri;
Tri[][] triangles;

int count = 0;
boolean gifing = true;

void setup(){
 size(400,400);
 background(0); 
  
 triangles = new Tri[20][20]; 
  
 color[] col = {#FF00FF, #00FFFF, #9900FF, #00FF99};
 for(int i =0; i < 20; i ++){
  for(int y = 0; y < 20; y++){
   triangles[i][y] = new Tri(20+(370/25)*i + i*5 ,(370/25)*y + y%40,  20+(370/25)*y + y*5,  20+(370/25)*y + y*5 + 20 , (370/50), i%2==0 ? true : false, col); 
  }
 }
  gifExport = new GifMaker(this, "tri.gif");
  gifExport.setRepeat(0);
}

void draw(){
  noStroke();
  fill(0,150);
  rect(0,0,400,400);
  for(int i =0; i < 20; i ++){
  for(int y = 0; y < 20; y++){
   triangles[i][y].display(); 
   triangles[i][y].move(.1, (count%2==0));
  }
 }
  filter(BLUR, 1.0);
  
  if(gifing) {
    if( count % 2 == 0 && count > 130){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 152){
        gifExport.finish(); 
        gifing = false;
    }
    count++;
  }
  
}


class Tri {
   float x, y;
   float miny;
   float maxy;
   float distance;
   boolean growing;
   color[] colors;
   int cindex =0;

   Tri(float x, float y, float miny, float maxy, float distance,boolean grow, color [] colors){
    this.x = x;
    this.y = y;
    this.miny = miny;
    this.maxy = maxy;
    this.distance = distance;
    this.growing = grow;
    this.colors = colors;
   } 
  
   void move(float percentage, boolean inc){
     float length = (maxy - miny)*percentage;
     if(inc)
      cindex++; 
     if(cindex > colors.length-1)
       cindex = 0;
     if(growing){
       if((y+=length) > maxy){
         y = maxy;
         growing = false;  
       }
     }
     else{
       if((y-=length) < miny){
         y = miny;
         growing = true;  
         cindex = 0;
       }
     }
     
   }
  
   void display(){
    noFill();
    float[] top = {x,y-distance};
    float[] bottomleft = {x - distance, y + distance};
    float[] bottomright ={x + distance, y + distance};
    
    noStroke();
    fill(colors[cindex], 30);
    triangle(top[0],top[1], bottomleft[0],
             bottomleft[1], bottomright[0], 
             bottomright[1]);  
    
    strokeWeight(5);
    stroke(colors[cindex], 80);
    
    triangle(top[0],top[1], bottomleft[0],
             bottomleft[1], bottomright[0], 
             bottomright[1]);
    
    strokeWeight(2);
    stroke(colors[cindex], 230);
    triangle(top[0],top[1], bottomleft[0],
             bottomleft[1], bottomright[0], 
             bottomright[1]);
    
    strokeWeight(1);
    stroke(#FFFFFF, 250);
    triangle(top[0],top[1], bottomleft[0],
             bottomleft[1], bottomright[0], 
             bottomright[1]);
                 
   }  
}
