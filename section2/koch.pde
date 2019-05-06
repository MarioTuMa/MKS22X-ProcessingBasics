int levels;
color bg,fg;

void setup() {
  size(800, 600);
  levels = 1;
}

/*Create Pascal's Gasket (google an image of this)
  The outer triangle are the vertices: (v1x, v1y), (v2x,v2y), (v3x, v3y)
  levels:
  0 = regular triangle
  1 = triforce (looks like 3 triangles)
  2 = each of the 3 triangles will be cut into 3 triangles.
  etc.
*/
void koch(int levels, float v1x, float v1y, float v2x, float v2y, float v3x, float v3y) {
    if(levels==0){
      line(v1x,v1y,v2x,v2y);
    }
    else{
      
       koch(levels-1,v1x,v1y,(2*v1x+v2x)/3,(2*v1y+v2y)/3,v3x,v3y);
       koch(levels-1,v2x,v2y,(2*v2x+v1x)/3,(2*v2y+v1y)/3,v3x,v3y);
       float dist = (float) (Math.sqrt(3*((v1x-v2x)*(v1x-v2x)+(v1y-v2y)*(v1y-v2y))))/6.0;
       float vecdist = (float) (-1*(Math.sqrt(1+((v1x-v2x)/(v2y-v1y)*(v1x-v2x)/(v2y-v1y)))));
       
       float coord10 = (v1x+v2x)/2+(dist/vecdist)*(1);
       float coord20 = (v1y+v2y)/2+(dist/vecdist)*((v1x-v2x)/(v2y-v1y));
       float coord11 = (v1x+v2x)/2-(dist/vecdist)*(1);
       float coord21 = (v1y+v2y)/2-(dist/vecdist)*((v1x-v2x)/(v2y-v1y));
       float coord1,coord2;
       if((coord10-v3x)*(coord10-v3x)+(coord20-v3y)*(coord20-v3y)>(coord11-v3x)*(coord11-v3x)+(coord21-v3y)*(coord21-v3y)){
         coord1=coord10;
         coord2=coord20;
       }
       else{
         coord1=coord11;
         coord2=coord21;
       }
       
       koch(levels-1,coord1,coord2,(2*v2x+v1x)/3,(2*v2y+v1y)/3,v3x,v3y);
       koch(levels-1,coord1,coord2,(2*v1x+v2x)/3,(2*v1y+v2y)/3,v3x,v3y);
     
    }  
    
}

void draw() { 
  background(50);  
  
  fill(255);
  text("Click the mouse to increase levels, press a key to decrease levles",20,20);

  koch(levels,0, height-10, width, height-10, width/2, 10);
  koch(levels,width/2, 10,0, height-10, width, height-10);
  koch(levels,width, height-10,width/2, 10,0, height-10 );

 //koch(levels,width-10, height/2,10, height/3 ); 
 //other fractal you can do! This requires a bit more math, or you can look up the coordinates.
}

void mouseClicked(){ 
 levels ++;  
}

void keyPressed(){
 if(levels>0){
   levels --;
 } 
}
