import gifAnimation.*;

GifMaker gifExport;

GlowSquare[][] squares;

int count = 0;
boolean gifing = true;

void setup(){
 size(400,200); 
 background(0);
 rectMode(CENTER);
 
 color pink = #FF00FF;
 color blue = #00FFFF;
 
 color[] greenpurp = {#FF0000, #FF8000, #FFFF00, #40FF00, 
                    #00FFFF, #0000FF, #8000FF, #FF00FF,
                    #FF0080};
 squares = new GlowSquare[9][5];
 float offset = (285/squares.length)/4;
 for(int i = 0; i < squares.length; i++){
   for(int y = 0; y < squares[0].length; y++){
      squares[i][y] = new GlowSquare(i*(285/squares.length) + (i)*offset + offset*7,
                                     y*(285/squares.length) + (y)*offset + offset*3,
                                     (350/squares.length), greenpurp[i]); 
                                     
                                     
      println(((float)i/(squares.length)));                               
     squares[i][y].setMove((285/squares.length)/4, (285/squares.length)/2, 
                            ((abs(4-i)))/1.5, true);                                
   }
 }
 
 gifExport = new GifMaker(this, "glowsticks.gif");
  gifExport.setRepeat(0);
}

void draw(){
  fill(0,25);
  rect(200,200,400,400);
  
  for(int i = 0; i < squares.length; i++){
     for(int y = 0; y < squares[0].length; y++){
         squares[i][y].display();
         squares[i][y].move(.1);
     }
  }
  
   filter(BLUR, 2);
   
   if(gifing) {
    if( count % 2== 0 && count > 200 ){
      gifExport.setDelay(0);
      gifExport.addFrame();
    }
    if(count == 228){
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
  
   noStroke();
        
   fill(c, 80);
   rect(x,y,w, w,7);
   fill(c, 250);
   rect(x,y,w/2, w/2,7);
   fill(255,255,255,230);
   rect(x,y,w/2.5, w/2.5,7);
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
