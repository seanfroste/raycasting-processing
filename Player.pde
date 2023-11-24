class Player {
  float fov;
  PVector position;
  ArrayList<Ray> rays;
  float dir;

  Player() {
    fov = 90;
    position = new PVector(400/2, 400/2);
    rays = new ArrayList<>();
    dir = 0;
    for (float a = -fov / 2; a < fov / 2; a++) {
      rays.add(new Ray(position, radians(a)));
    }
  }

  void update_FOV(float fov) {
    this.fov = fov;
    rays = new ArrayList<>();
    for (float a = -fov / 2; a < fov / 2; a++) {
      rays.add(new Ray(position, radians(a) + dir));
    }
  }

  void rotate(float angle) {
    dir += angle;
    int index = 0;
    for (float a = -fov / 2; a < fov / 2; a++) {
      rays.get(index).set_dir(radians(a) + dir);
      index++;
    }
  }

  void move(float amt) {
    PVector vel = PVector.fromAngle(dir);
    vel.setMag(amt);
    position.add(vel);
  }

  void update(float x, float y) {
    position.set(x, y);
  }

  ArrayList<Float> look(ArrayList<Blocker> walls) {
    ArrayList<Float> scene = new ArrayList<>();
    for (int i = 0; i < rays.size(); i++) {
      Ray ray = rays.get(i);
      PVector closest = null;
      float record = Float.MAX_VALUE;
      for (Blocker wall : walls) {
        PVector pt = ray.cast(wall);
        if (pt != null) {
          float d = PVector.dist(position, pt);
          float a = ray.dir.heading() - dir;
          if (!mousePressed) {
            d *= cos(a);
          }
          if (d < record) {
            record = d;
            closest = pt;
          }
        }
      }
      if (closest != null) {
        // colorMode(HSB);
        // stroke((i + frameCount * 2) % 360, 255, 255, 50);
        stroke(255, 100);
        line(position.x, position.y, closest.x, closest.y);
      }
      scene.add(record);
    }
    return scene;
  }

  void show() {
    fill(255);
    circle(position.x, position.y, 4);
    for (Ray ray : rays) {
      ray.show();
    }
  }
}
