import gifAnimation.*;

GifMaker gifExport;

GlowSquare[][] squares;

int count = 0;
boolean gifing = true;

void setup(){
 size(400,400); 
 background(0);
 rectMode(CENTER);
 
 color pink = #FF00FF;
 color blue = #00FFFF;
 
 color[] greenpurp = {#0000FF, #8000FF, #FF00FF,
                    #FF0080, #FF0000, #FF8000, #FFFF00, #40FF00, 
                    #00FFFF,};
 squares = new GlowSquare[9][9];
 float offset = (285/squares.length)/4;
 for(int i = 0; i < squares.length; i++){
   for(int y = 0; y < squares[0].length; y++){
      squares[i][y] = new GlowSquare(i*(285/squares.length) + (i)*offset + offset*7,
                                     y*(285/squares.length) + (y)*offset + offset*7,
                                     (350/squares.length), greenpurp[i]); 
                                     
                                     
      println(((float)i/(squares.length)));                               
     squares[i][y].setMove((285/squares.length)/4, (285/squares.length)*2, 
                            abs(9-y)/1.9, true);                                
   }
 }
 
 gifExport = new GifMaker(this, "glowsquar.gif");
  gifExport.setRepeat(0);
}

void draw(){
  noStroke();
  fill(0,15);
  rect(200,200,400,400);
  
   for(int i = squares.length -1; i >= 0; i--){
     for(int y = squares[0].length -1; y >= 0; y--){
         squares[i][y].display();
         squares[i][y].move(.1);
     }
  }
  
  
   filter(BLUR, 2);
   
   if(gifing) {
    if( count % 4== 0 && count > 200 ){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 244){
        gifExport.finish(); 
        gifing = false;
    }
    count++;
  }
}

class GlowSquare {
 float x,y, w;
 float minw, maxw;
 float percentDelay;
 color c;
 int colorIndex = 0;
 boolean growing = true;
 
 
 GlowSquare(float x, float y, float w, color cs){
   this.x = x;
   this.y = y;
   this.w = w;
   this.c = cs;
 }  
  
 void display(){
  
   noFill();
        
   stroke(c, 80);
   strokeWeight(6);
   rect(x,y,w, w,1);
   stroke(c, 250);
   strokeWeight(4);
   rect(x,y,w, w,1);
   stroke(255,255,255,230);
   strokeWeight(2);
   rect(x,y,w, w,1);
 }

 void setMove(float minwidth, float maxwidth, float delay, boolean grow){
   this.minw = minwidth;
   this.maxw = maxwidth;
   this.percentDelay = delay; 
   if(grow){
     w = minw;
     growing = true;
   }
   else{
     w = maxw;
     growing = false;
   }
 }

 void move(float percentage){
  if((percentDelay = percentDelay - percentage) < 0){
     if(growing) {
       if((w += w*percentage) > maxw){
          w = maxw;
          growing = false;
       } 
     }
     else{
       if((w -= w*percentage) < minw){
          w = minw;
          growing = true;
       } 
     } 
  }
 }

}
