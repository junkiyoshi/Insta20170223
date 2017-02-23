import de.voidplus.leapmotion.*;

LeapMotion leap;
ArrayList<PVector> history;
float angle; 
boolean turn;

void setup()
{
  size(800, 800, P3D);
  
  leap = new LeapMotion(this);
  history = new ArrayList<PVector>();
  angle = 0;
  turn = false;
  
  background(0);
}

void draw()
{  
  background(0);
  
  if(!turn)
  {
    for(Hand h : leap.getHands())
    {
      if(h.isRight())
      {
        Finger f = h.getIndexFinger();
        history.add(new PVector(f.getPosition().x, f.getPosition().y, f.getPosition().z * -6));
      }
    }
  }
  
  stroke(255, 255, 0);
  strokeWeight(10);
  noFill();
  
  beginShape();
  for(PVector p : history)
  {
    vertex(p.x, p.y, p.z);
  }
  endShape();
  
  if(turn)
  {
    angle = (angle + 1) % 360;
    float radius = 800;
    float x = radius * cos(radians(angle));
    float z = radius * sin(radians(angle));
    
    camera(x + width / 2.0, height / 2.0, z, 
         width / 2.0, height / 2.0, 0.0, 
         0.0, 1.0, 0.0);
  }
}

void keyPressed()
{
  if(key == 'c')
  {
    history.clear();
    
    camera(width / 2.0, height / 2.0, (height / 2.0) / tan(PI*60.0 / 360.0),
       width/2.0, height/2.0, 0,
       0.0, 1.0, 0.0); 
    
    turn = false;
  }
  
  if(key == 'x')
  {
    turn = !turn;
  }
}