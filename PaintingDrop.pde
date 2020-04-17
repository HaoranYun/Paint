
class PaintingDrop{
  PVector pos;
  PVector vel;
  PVector gravity = new PVector(0, 0.001,0);
  //float dt = 0.1;
  PShape dropShape;
  
  PaintingDrop(PVector position, PVector prevPosition){
    pos = position.copy();
    vel = new PVector(0,0,0);
    dropShape = createShape(LINE,pos.x,pos.y,pos.z,prevPosition.x, prevPosition.y, prevPosition.z);
  }
  
  
  void update(float dt){
    vel.add(PVector.mult(gravity,dt));
    PVector trans = PVector.mult(vel,dt);
    pos.add(trans);
    
    if(pos.y > -1) {
      pos.y = 0;
      trans = new PVector(0,0,0);
    }
    
     
     
    dropShape.translate(trans.x,trans.y,trans.z);
    dropShape.setTint(brushCol);
  }
  
}
