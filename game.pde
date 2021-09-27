
int boundRadius = 30;
int boundSize = 20;
int rows, cols;
int scl = boundRadius*2;
ArrayList<boundary> boundaries = new ArrayList<boundary>();
ArrayList<wall> walls = new ArrayList<wall>();
ArrayList<enemy> enemies = new ArrayList<enemy>();
ArrayList<enemyBoundary> enemyboundaries = new ArrayList<enemyBoundary>();
ArrayList<enemyWall> enemyWalls = new ArrayList<enemyWall>();
float TotalEnemies = 3;

boolean lefting, righting, move, flip;
boolean start = true;

player player;
enemy enemy;

void setup() {
  enemy = new enemy();
  size(600, 600);
  player = new player();
  rows = height/scl;
  cols = width/scl;
  createBoundaries();
  createEnemies();
  createRays();
}

void draw() {
  background(0);
  playerStuff();
  enemyStuff();
  wallStuff();
}


void keyPressed() {
  if (key == 'd' || key == 'D') {
    lefting = false;
    righting = true;
  } else if (key == 'a' || key == 'A') {
    righting = false;
    lefting = true;
  } else if (key == 'w' || key == 'W') {
    move = true;
  }
}

void keyReleased() {
  if (key == 'd' || key == 'D') {
    righting = false;
  } else if (key == 'a' || key == 'A') {
    lefting = false;
  } else if (key == 'w' || key == 'W') {
    move = false;
    player.totalDir = 0;
    player.averageDirAngle = 0;
  } else if (key == 's' || key == 'S') {
    flip();
  }
}

void flip() {
  player.averageDir.mult(-1);
  for (ray r : player.view) {
    r.start+=PI;
  }
}

void wallStuff() {
  for (boundary b : boundaries) {
    b.show();
  }
}

void createRays() {
  for (float i = -player.fov/2; i < player.fov/2; i+=radians(1)) {
    player.view.add(new ray(i, player.pos));
  }
  for (enemy e : enemies) {
    for (float i = -enemy.fov/2; i < enemy.fov/2; i+=radians(5)) {
      e.view.add(new ray(i, e.pos));
    }
  }
}

void playerStuff() {
  player.update();
  edgesOfRayPos();
  for (ray r : player.view) {
    r.rayCollidesWithStuff();
    r.playerMove(.05);
  }
  player.edges();
  player.show();
  player.showSee();
}

void enemyStuff() {
  for (enemy e : enemies) {
    e.update(.01);
    e.showRays();
  }
}

void createBoundaries() {
  for (int i = 0; i < boundSize; i++) {
    int x = int(random(2, cols-2))*scl;
    int y = int(random(2, rows-2))*scl;
    boundaries.add(new boundary(boundRadius, x, y));
    enemyboundaries.add(new enemyBoundary(boundRadius,x,y));
  }

  // screen boundaries
  walls.add(new wall(0, 0, width, 0));
  walls.add(new wall(0, 0, 0, height));
  walls.add(new wall(0, height, width, height));
  walls.add(new wall(width, 0, width, height));
}


void edgesOfRayPos() {
  int[] distancesFromRayToOutsideOfBox = new int[4];
  for (ray r : player.view) {
    for (boundary b : boundaries) {
      if (r.pos.x >= b.pos.x-player.r && r.pos.x <= b.pos.x + b.r*2 + player.r && r.pos.y >= b.pos.y - player.r  && r.pos.y <= b.pos.y + b.r*2 + player.r) {
        // if inside the box, teleport to the closest distance to get outside the box.
        distancesFromRayToOutsideOfBox[0] = int(dist(r.pos.x, r.pos.y, b.pos.x +b.r*2, r.pos.y));
        // right wall
        distancesFromRayToOutsideOfBox[1] = int(dist(r.pos.x, r.pos.y, r.pos.x, b.pos.y +b.r*2));
        // bottom wall
        distancesFromRayToOutsideOfBox[2] = int(dist(r.pos.x, r.pos.y, b.pos.x, r.pos.y));
        // left wall
        distancesFromRayToOutsideOfBox[3] = int(dist(r.pos.x, r.pos.y, r.pos.x, b.pos.y));
        // top wall
        if (distancesFromRayToOutsideOfBox[0] < distancesFromRayToOutsideOfBox[1] && distancesFromRayToOutsideOfBox[0] < distancesFromRayToOutsideOfBox[2] && distancesFromRayToOutsideOfBox[0] < distancesFromRayToOutsideOfBox[3]) {
          // the closest wall was the right wall
          // print("closest wall is Right wall");
          r.pos.x = b.pos.x + b.r*2 + player.r;
        } else if (distancesFromRayToOutsideOfBox[1] < distancesFromRayToOutsideOfBox[0] && distancesFromRayToOutsideOfBox[1] < distancesFromRayToOutsideOfBox[2] && distancesFromRayToOutsideOfBox[1] < distancesFromRayToOutsideOfBox[3]) {
          // the closest wall was the bottom wall
          //print("closest wall is bottom wall");
          r.pos.y = b.pos.y + b.r*2+ player.r;
        } else if (distancesFromRayToOutsideOfBox[2] < distancesFromRayToOutsideOfBox[0] && distancesFromRayToOutsideOfBox[2] < distancesFromRayToOutsideOfBox[1] && distancesFromRayToOutsideOfBox[2] < distancesFromRayToOutsideOfBox[3]) {
          // the closest wall was the left wall
          // print("closest wall is left wall");
          r.pos.x = b.pos.x-player.r;
        } else if (distancesFromRayToOutsideOfBox[3] < distancesFromRayToOutsideOfBox[0] && distancesFromRayToOutsideOfBox[3] < distancesFromRayToOutsideOfBox[2] && distancesFromRayToOutsideOfBox[3] < distancesFromRayToOutsideOfBox[1]) {
          // the closest wall was the top wall
          //print("closest wall is top wall");
          r.pos.y = b.pos.y-player.r;
        }
      }
    }
  }
}

void createEnemies() {
  for (int i = 0; i < TotalEnemies; i++) {
    enemies.add(new enemy());
  }
}
