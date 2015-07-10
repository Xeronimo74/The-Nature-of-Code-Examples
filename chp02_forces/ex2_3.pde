// solution proposed by Jerome Herr, http://p5art.tumblr.com

int num = 100;
float startOfForceField = 50;
float repel = 1.6;
Mover[] movers = new Mover[num];
 
void setup() {
  size(540, 300);
  smooth(4);
  colorMode(HSB, 360, 100, 100);
  for (int i=0; i<movers.length; i++) {
    movers[i] = new Mover(random(0.2,2), 60, 60);
  }
}
 
void draw() {
  background(#000000);
   
  PVector wind = new PVector(0.03, 0);
  PVector gravity = new PVector(0, 0.1);
 
  for (int i=0; i<movers.length; i++) {
    movers[i].applyForceField();
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
 
    movers[i].update();
    movers[i].display();
  }
  //if (frameCount<350) saveFrame("image-###.tif");
  //if (frameCount==350) noLoop();
}
 
class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass, sz;
  int col;
 
  Mover(float m, float x, float y) {
    mass = m;
    sz = mass*16;
    col = (int) random(360);
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
 
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
 
  void update() {
    velocity.add(acceleration);
    //velocity.limit(8);
    location.add(velocity);
 
    acceleration.mult(0);
  }
 
  void display() {
    stroke(col, 90, 0);
    strokeWeight(2);
    //noStroke();
    fill(col, 90, 90);
 
    ellipse(location.x, location.y, sz, sz);
  }
 
  void applyForceField() {
    if (location.x < startOfForceField) {
      float left = map(dist(0, location.y, location.x, location.y), startOfForceField, 0, 0, repel);
      applyForce(new PVector(left, 0));
    }
    if ( location.x > width-startOfForceField) {
      float right = map(dist(width, location.y, location.x, location.y), startOfForceField, 0, 0, -repel);
      applyForce(new PVector(right, 0));
    }
    if ( location.y < startOfForceField) {
      float top = map(dist( location.x, 0, location.x, location.y), startOfForceField, 0, 0, repel);
      applyForce(new PVector(0, top));
    }
    if ( location.y > height-startOfForceField) {
      float bottom = map(dist( location.x, height, location.x, location.y), startOfForceField, 0, 0, -repel);
      applyForce(new PVector(0, bottom));
    }
  }
}
