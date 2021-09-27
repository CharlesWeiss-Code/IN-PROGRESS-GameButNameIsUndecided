class enemy {
  ArrayList<ray> view = new ArrayList<ray>();
  ArrayList<PVector> ableToSee = new ArrayList<PVector>();

  PVector pos;
  int viewR = 300;
  float fov = PI/2;
  float speed = 3;
  boolean righting, lefting;
  int r = 32;
  boolean isSeen = false;

  enemy() {
    choosePos();
    righting = true;
  }

  void choosePos() {
    int startX = int(random(width));
    int startY = int(random(height));
    for (boundary b : boundaries) {
      int x = startX;
      int y = startY;
      if (x > b.pos.x-b.r*2 && x < b.pos.x+b.r*2 && y < b.pos.y+b.r*2 && y > b.pos.y-b.r*2) {
        choosePos();
      } else {
        pos = new PVector(x, y);
      }
    }
  }
  // adaptation of other line-line intersection
  void seePlayer() {
  }


  void show() {
    push();
    fill(255, 0, 0);
    ellipse(pos.x, pos.y, r, r);
    pop();
    view.clear();
  }

  void showRays() {
    color COLOR = color(255, 0, 0);
    for (ray r : view) {
      ableToSee.add(r.rayCollidesWithStuff1());
      r.show(.05, COLOR);
    }
  }
  void update(float angle) {
    // it moves if you do // possible power up ability
    if (righting) {
      for (ray r : view) {
        r.dir = PVector.fromAngle(r.start);
        r.start+=angle;
      }
      // adjust angle and position based on randomness;
      // however if you do see the player than go after it;
    }
    walls.add(new wall(pos.x-r/4, pos.y+r/4, pos.x-r/4, pos.y-r/4));
    walls.add(new wall(pos.x-r/4, pos.y-r/4, pos.x+r/4, pos.y-r/4));
    walls.add(new wall(pos.x+r/4, pos.y-r/4, pos.x+r/4, pos.y+r/4));
    walls.add(new wall(pos.x+r/4, pos.y+r/4, pos.x-r/4, pos.y+r/4));
    ableToSee.clear();
  }
}
