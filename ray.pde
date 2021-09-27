class ray {
  PVector pos;
  PVector dir;
  float start;
  int count = 0;
  PVector closest = null;
  PVector circleClosest = null;

  ray(float a, PVector position) {
    pos = position;
    start = a;
    dir = PVector.fromAngle(a);
    dir.normalize();
  }

  void rayCollidesWithStuff() {
    float record = 999999999;
    for (wall w : walls) {
      PVector intPoint = null;
      float intx;
      float inty;

      float x1 = w.a.x;
      float y1 = w.a.y;
      float x2 = w.b.x;
      float y2 = w.b.y;

      float x3 = pos.x;
      float y3 = pos.y;
      float x4 = pos.x + dir.x;
      float y4 = pos.y + dir.y;

      float den = ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4));
      if (den == 0) {
        return;
      }

      float t = (((x1 -x3) * (y3-y4)) - ((y1 - y3) * (x3 - x4)))/den;
      float u = -(((x1-x2) * (y1-y3)) - ((y1 - y2) * (x1 - x3)))/den;

      if (t >= 0 && t <=1 && u <= 1) {
        intx = x1 + t * (x2 - x1);
        inty = y1 + t * (y2 - y1); 
        intPoint = new PVector(intx, inty);
      }
      if (intPoint != null) {
        float d = PVector.dist(pos, intPoint);
        if (d < record) {
          record = d;
          closest = intPoint;
        }
      }
    }
    player.ableToSee.add(closest);
  }

  PVector rayCollidesWithStuff1() {
    float record = 999999999;
    for (enemyWall w : enemyWalls) {
      print(enemyWalls.size());
      PVector intPoint = null;
      float intx;
      float inty;

      float x1 = w.a.x;
      float y1 = w.a.y;
      float x2 = w.b.x;
      float y2 = w.b.y;

      float x3 = pos.x;
      float y3 = pos.y;
      float x4 = pos.x + dir.x;
      float y4 = pos.y + dir.y;

      float den = ((x1 - x2) * (y3 - y4)) - ((y1 - y2) * (x3 - x4));
      if (den == 0) {
        return null;
      }

      float t = (((x1 -x3) * (y3-y4)) - ((y1 - y3) * (x3 - x4)))/den;
      float u = -(((x1-x2) * (y1-y3)) - ((y1 - y2) * (x1 - x3)))/den;

      if (t >= 0 && t <=1 && u <= 1) {
        intx = x1 + t * (x2 - x1);
        inty = y1 + t * (y2 - y1); 
        intPoint = new PVector(intx, inty);
      }
      if (intPoint != null) {
        float d = PVector.dist(pos, intPoint);
        if (d < record) {
          record = d;
          closest = intPoint;
        }
      }
    }
    return closest;
  }
  void show(float a, color c) {
    if (closest != null) {
      stroke(c);
      line(pos.x, pos.y, closest.x, closest.y);
    }
    if (righting) {
      dir = PVector.fromAngle(start);
      start+=a;
    } else if (lefting) {
      dir = PVector.fromAngle(start);
      start-=a;
    }
  }

  void playerMove(float a) {
    if (righting) {
      dir = PVector.fromAngle(start);
      start+=a;
    } else if (lefting) {
      dir = PVector.fromAngle(start);
      start-=a;
    }
  }
}
