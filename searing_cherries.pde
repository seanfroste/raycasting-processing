ArrayList<Blocker> walls;
Player player;
float x=0;
float y=10000;

void setup() {
  size(800, 400);
  walls = new ArrayList<>();
  for (int i=0; i<5; i++) {
    float x1 = random(400);
    float x2 = random(400);
    float y1 = random(400);
    float y2 = random(400);
    walls.add(new Blocker(x1, y1, x2, y2));
  }
  walls.add(new Blocker(0, 0, 400, 0));
  walls.add(new Blocker(400, 0, 400, 400));
  walls.add(new Blocker(400, 400, 0, 400));
  walls.add(new Blocker(0, 400, 0, 0));
  player = new Player();
}

void draw() {
  float fovValue = 90;
  if (mouseX <=2) {
    fovValue = 2;
  } else if (mouseX >= width/2) {
    fovValue = 360;
  } else {
    fovValue = map(mouseX, 0, width/2, 0, 360);
  }
  player.update_FOV(fovValue);

  if (keyPressed && key == CODED) {
    if (keyCode == LEFT) {
      player.rotate(-0.1);
    } else if (keyCode == RIGHT) {
      player.rotate(0.1);
    } else if (keyCode == UP) {
      player.move(2);
    } else if (keyCode == DOWN) {
      player.move(-2);
    }
  }

  background(0);
  for (Blocker wall : walls) {
    wall.show();
  }
  player.show();

  ArrayList<Float> scene = player.look(walls);
  float w = 400 / scene.size();

  push();
  translate(400, 0);
  for (int i = 0; i < scene.size(); i++) {
    noStroke();
    float sq = scene.get(i) * scene.get(i);
    float wSq = 400 * 400;
    float b = map(sq, 0, wSq, 255, 0);
    float h = map(scene.get(i), 0, 400, 400, 0);
    fill(b);
    rectMode(CENTER);
    rect(i * w + w / 2, 400 / 2, w + 1, h);
  }
  pop();
}
