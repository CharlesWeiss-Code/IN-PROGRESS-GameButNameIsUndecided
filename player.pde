class player {
  float fov = PI/2;
  float totalDir;
  int index;
  float a;
  float r = boundRadius/4;
  float averageDirAngle;
  PVector averageDir;
  ArrayList<ray> view = new ArrayList<ray>();
  ArrayList<PVector> ableToSee = new ArrayList<PVector>();
  ArrayList<PVector> intPoints = new ArrayList<PVector>();
  PVector pos = new PVector(width/2, height/8);
  float speed = 4;

  void update() {
    index = int(view.size()/2);
    a = view.get(index).start;
    if (move) {
      averageDir = PVector.fromAngle(a);
      averageDir.setMag(-speed);
      pos.add(averageDir);
    }
  }

  void show() {
    push();
    fill(0, 0, 255);
    ellipse(pos.x, pos.y, r*2, r*2);
    pop();
    enemyWalls.clear();
    intPoints.clear();
  }

  void showSee() {
    push();
    beginShape();
    vertex(pos.x, pos.y);
    for (int i = 0; i < ableToSee.size(); i++) {
      color w = color(255);
      color b = color(0);
      float lerpAmmount = map(PVector.dist(pos, ableToSee.get(i)), 0, height, 0, 1);
      color COLOR = lerpColor(w, b, lerpAmmount);
      fill(COLOR);
      vertex(ableToSee.get(i).x, ableToSee.get(i).y);
      for (enemy e : enemies) {
        if (ableToSee.get(i).x == e.pos.x+e.r/4 && ableToSee.get(i).y > e.pos.y-e.r/4 && ableToSee.get(i).y < e.pos.y+e.r/4 || ableToSee.get(i).x == e.pos.x-e.r/4 && ableToSee.get(i).y < e.pos.y+e.r/4 && ableToSee.get(i).y > e.pos.y-e.r/4 || ableToSee.get(i).y == e.pos.y+e.r/4 && ableToSee.get(i).x > e.pos.x-e.r/4 && ableToSee.get(i).x < e.pos.x+e.r/4 || ableToSee.get(i).y == e.pos.y-e.r/4 && ableToSee.get(i).x < e.pos.x+e.r/4 && ableToSee.get(i).x > e.pos.x-e.r/4) {
          e.show();
        }
      }
    }
    endShape(CLOSE);
    ableToSee.clear();
    pop();
  }

  void edges() {
    if (pos.x >= width-1) {
      pos.x = 1;
    } else if (pos.x <=1) {
      pos.x = width-1;
    } else if (pos.y >= height-1) {
      pos.y = 1;
    } else if (pos.y <= 1) {
      pos.y = height-1;
    }
  }
}
