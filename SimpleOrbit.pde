final float ANGULAR_VELOCITY = 2*PI/180;
final float SPEED_FACTOR = 2;

RotatingLine orbit = new RotatingLine(350,350,0,ANGULAR_VELOCITY,200);
RotatingLine arm = new RotatingLine(
orbit.endCoords.x,
orbit.endCoords.y,
PI,
SPEED_FACTOR*ANGULAR_VELOCITY,
90
);



boolean keyReleased = false;

void setup(){
  size(700,700);
}

float t = 0;
void draw(){
  if(keyPressed){
    t+=0.25;
  }else{
    t+= 0.5;
  }
  
  if(keyReleased){
    t = (int)t;
    keyReleased = false;
  }
  
  float orbitAngle = t*orbit.angularVelocity;
  
  background(255);
  ellipse(orbit.startCoords.x,orbit.startCoords.y,100,100);
  stroke(0,0,255);
  orbit.update(t,false);
  arm.startCoords = orbit.endCoords.copy();
  arm.startAngle = 0;
  stroke(255,0,0);
  arm.update(t,true);
  arm.startAngle = PI;
  arm.update(t,false);
  point(arm.endCoords.x,arm.endCoords.y);
  drawVelVector(orbit,arm,t);
  stroke(0);
  drawPath(orbit,arm);
  drawArrow(orbit.startCoords.x,orbit.startCoords.y,arm.endCoords.x,arm.endCoords.y);
}

void drawVelVector(RotatingLine o, RotatingLine a, float t){
  float theta = t*ANGULAR_VELOCITY;
  PVector velVector = new PVector();
  velVector.x = -ANGULAR_VELOCITY*o.distance*sin(theta)-SPEED_FACTOR*ANGULAR_VELOCITY*a.distance*sin(SPEED_FACTOR*theta+PI);
  velVector.y = ANGULAR_VELOCITY*o.distance*cos(theta)+SPEED_FACTOR*ANGULAR_VELOCITY*a.distance*cos(SPEED_FACTOR*theta+PI);
  stroke(255,0,255);
  drawSmallArrow(a.endCoords.x,a.endCoords.y,a.endCoords.x+velVector.x,a.endCoords.y+velVector.y);
  stroke(0);
  //drawSmallArrow(a.endCoords.x,a.endCoords.y,a.endCoords.x+velVector.x,a.endCoords.y);
  //drawSmallArrow(a.endCoords.x,a.endCoords.y,a.endCoords.x,a.endCoords.y+velVector.y);
  
}

void drawArrow(float x1, float y1, float x2, float y2) {
  float a = dist(x1, y1, x2, y2) / 50;
  pushMatrix();
  translate(x2, y2);
  rotate(atan2(y2 - y1, x2 - x1));
  triangle(- a * 2 , - a, 0, 0, - a * 2, a);
  popMatrix();
  line(x1, y1, x2, y2);  
}

void drawSmallArrow(float x1, float y1, float x2, float y2){
  float a = 3;
  pushMatrix();
  translate(x2, y2);
  rotate(atan2(y2 - y1, x2 - x1));
  triangle(- a * 2 , - a, 0, 0, - a * 2, a);
  popMatrix();
  line(x1, y1, x2, y2); 
}

void drawPath(RotatingLine o, RotatingLine a){
  for (float theta = 0; theta < 2*PI; theta+=0.1){
    float x = o.startCoords.x+o.distance*cos(theta)+a.distance*cos(SPEED_FACTOR*theta+PI);
    float y = o.startCoords.y+ o.distance*sin(theta)+a.distance*sin(SPEED_FACTOR*theta+PI);
    strokeWeight(2);
    point(x,y);
    strokeWeight(1);
  }
}

void keyReleased(){
  keyReleased = true;
}
