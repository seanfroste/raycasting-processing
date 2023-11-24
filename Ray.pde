class Ray {
  PVector position;
  PVector dir;

  Ray(PVector position, float angle) {
    this.position = position;
    this.dir = PVector.fromAngle(angle);
  }

  void set_dir(float angle) {
    dir = PVector.fromAngle(angle);
  }

  void look_at(float x, float y) {
    dir.x = x - position.x;
    dir.y = y - position.y;
    dir.normalize();
  }

  void show() {
    stroke(255);
    push();
    translate(position.x, position.y); // move the coordinate system to the starting position
    line(0, 0, dir.x*10, dir.y*10);
    pop();
  }

  PVector cast(Blocker wall) {
    float x1 = wall.a.x;
    float y1 = wall.a.y;
    float x2 = wall.b.x;
    float y2 = wall.b.y;

    float x3 = position.x;
    float y3 = position.y;
    float x4 = position.x + dir.x;
    float y4 = position.y + dir.y;

    float den = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
    if (den == 0) {
      return null;
    }

    float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
    if ((0 < t && t < 1) && u > 0) {
      PVector pt = new PVector();
      pt.x = x1 + t * (x2 - x1);
      pt.y = y1 + t * (y2 - y1);
      return pt;
    } else {
      return null;
    }
  }
}
