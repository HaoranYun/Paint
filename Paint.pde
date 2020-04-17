import processing.sound.*;
int angle = 0;
Camera cam;
PaintingDrop dp;
ArrayList<PaintingDrop> drops;
color R = color(255,80,90); 
color G = color(60,200,100); 
color B = color(60,150,200);

PShape groupShape;
PShape brushObj;
color brushCol = R;
String brush = "red";
PImage texture;
SoundFile hitSound;

float startTime;
void setup() {
  //fullScreen(P3D);
  size(800, 600,P3D);
  brushObj = loadShape("./moon.obj");

  drops = new ArrayList<PaintingDrop>();

  groupShape = createShape(PShape.GROUP);
  cam = new Camera();
  hitSound = new SoundFile(this,"./hit.wav");
  
  startTime = millis();
  
  textSize(20);
}

void draw() {
  // Draw only when mouse is pressed
  background(0);
  directionalLight(255,255,255,0,1,0);
  cam.Update( 1.0/frameRate );
  
  drawSurface();
  
  fill(brushCol);
  strokeWeight(5);
  stroke(brushCol);
  if (mousePressed == true) {
    PVector pos = new PVector((float)(mouseX/2.5)-60,-100, (float)(mouseY/2.5)-45);
    PVector prevPos = new PVector((float)(pmouseX/2.5)-60,-100, (float)(pmouseY/2.5)-45);
    //println((float)(mouseX/4) + " " + (float)(mouseY/4));
    PaintingDrop drop = new PaintingDrop(pos,prevPos);
    drops.add(drop);
    groupShape.addChild(drop.dropShape);
  }
  
 
  if(drops.size() > 0){
    for(int i  = 0; i < drops.size(); i++){
      drops.get(i).update(millis() - startTime);
    }
    shape(groupShape);
  }
  
  pushMatrix();
  rotateX(PI/2);
  text("brush color:" + brush,0,0);
  popMatrix();
  
  
  drawBrush();
  startTime = millis();
  
  

}

void drawSurface(){
  pushMatrix();
  noStroke();
  fill(255,255,255);
  translate(0,0,0);
  rotateX(PI/2);
  rect(0,0,200,150);
  popMatrix();
}

void drawBrush(){
  pushMatrix();
  translate((float)(mouseX/2.5)-60 ,-100, (float)(mouseY/2.5)-45);
  rotateZ(PI/6);
  fill(brushCol);
  box(2,2,2);
  //scale(100);
  rotateY(PI/2);
  shape(brushObj);
  
  popMatrix();
}


void keyPressed()
{
  if ( key == '1' ) {
    brushCol = R;
    brush = "red";
  }
  if ( key == '2' ) {
    brushCol = G;
    brush = "green";
  }
  if ( key == '3' ) {
    brushCol = B;
    brush = "blue";
  }
 
  cam.HandleKeyPressed();
}

void keyReleased()
{
  cam.HandleKeyReleased();
}
