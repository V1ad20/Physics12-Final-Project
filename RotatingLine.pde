public class RotatingLine{
  public PVector startCoords;
  public PVector endCoords;
  public float startAngle;
  public float angularVelocity;
  public float distance;
  
  public RotatingLine(float x, float y, float startAngle, float angularVelocity, float distance){
    startCoords = new PVector(x,y);
    endCoords = new PVector();
    this.startAngle = startAngle;
    this.angularVelocity = angularVelocity;
    this.distance = distance;
  }
  
  public void update(float t,boolean showLine){
    float angle = t*angularVelocity+ startAngle;
    endCoords.x = startCoords.x+distance*cos(angle);
    endCoords.y = startCoords.y+distance*sin(angle);
    
    if (showLine){
        line(startCoords.x,startCoords.y,endCoords.x,endCoords.y);
    }else{
      drawArrow(startCoords.x,startCoords.y,endCoords.x,endCoords.y);
    }
  }
}
