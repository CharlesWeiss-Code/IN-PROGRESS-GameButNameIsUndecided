class enemyWall {
  PVector a = new PVector(0,0);
  PVector b = new PVector(0,0);
  
  enemyWall(PVector p1, PVector p2) {
    a = new PVector(p1.x,p1.y);
    b = new PVector(p2.x,p2.y);
  }
  enemyWall(float x1, float y1, float x2, float y2) {
    a.x = x1;
    a.y = y1;
    b.x = x2;
    b.y = y2;
  }
  
  void show() {
    stroke(255);
    line(a.x,a.y,b.x,b.y);
  }
}
