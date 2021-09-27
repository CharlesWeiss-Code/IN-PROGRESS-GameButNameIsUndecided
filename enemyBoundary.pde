class enemyBoundary {
  float r;
  PVector pos;
  PVector p1, p2, p3, p4 = new PVector(0, 0);
  enemyBoundary(float radius, float x, float y) {
    r = radius;
    pos = new PVector(x, y);

    p1 = new PVector(pos.x, pos.y);
    p2 = new PVector(pos.x+r*2, pos.y);
    p3 = new PVector(pos.x+r*2, pos.y+r*2);
    p4 = new PVector(pos.x, pos.y+r*2);

    enemyWalls.add(new enemyWall(p1, p2));
    enemyWalls.add(new enemyWall(p2, p3));
    enemyWalls.add(new enemyWall(p3, p4));
    enemyWalls.add(new enemyWall(p4, p1));
  }

  void show() {
    stroke(255);
    noFill();
    beginShape();
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    vertex(p3.x, p3.y);
    vertex(p4.x, p4.y);
    endShape(CLOSE);
  }
}
