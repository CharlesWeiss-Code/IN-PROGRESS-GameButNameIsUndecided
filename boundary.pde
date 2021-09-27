class boundary {
  float r;
  PVector pos;
  int colorRadius = 200;
  PVector p1, p2, p3, p4 = new PVector(0, 0);
  boundary(float radius, float x, float y) {
    r = radius;
    pos = new PVector(x, y);

    p1 = new PVector(pos.x, pos.y);
    p2 = new PVector(pos.x+r*2, pos.y);
    p3 = new PVector(pos.x+r*2, pos.y+r*2);
    p4 = new PVector(pos.x, pos.y+r*2);

    walls.add(new wall(p1, p2));
    walls.add(new wall(p2, p3));
    walls.add(new wall(p3, p4));
    walls.add(new wall(p4, p1));
  }

  //  void show() {
  //    stroke(255);
  //    noFill();
  //    beginShape();
  //    vertex(p1.x, p1.y);
  //    vertex(p2.x, p2.y);
  //    vertex(p3.x, p3.y);
  //    vertex(p4.x, p4.y);
  //    endShape(CLOSE);
  //  }
  //}

  void show() {
    color finalColor;
    push();
    strokeWeight(4);
    noFill();
    float record = 999999999;
    for (enemy e : enemies) {
      float d = PVector.dist(pos, e.pos);
      if (d < record) {
        record = d;
      }
    }
    color b = color(0, 0, 255);
    color r = color(255, 0, 0);
    float lerpAmmount = map(record, colorRadius/5, colorRadius, 1, 0);
    finalColor = lerpColor(b, r, lerpAmmount);
    fill(finalColor);
    beginShape();
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    vertex(p3.x, p3.y);
    vertex(p4.x, p4.y);
    endShape(CLOSE);
    pop();
  }
}
