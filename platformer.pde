boolean[] keys;

float sign(float n) {
  return n / abs(n);
}

class Platform {
  float x, y, l, h;
  
  Platform(float x, float y, float l, float h) {
    this.x = x;
    this.y = y;
    this.l = l;
    this.h = h;
  }
  
  float distanceRight(Man m) {
    return m.x - this.x - this.l;
  }
  
  float distanceLeft(Man m) {
    return this.x - m.x - 50;
  }
  
  float distanceUp(Man m) {
    return m.y - this.y;
  }
  
  float distanceDown(Man m) {
    return this.y - this.h - m.y - 200;
  }
  
  void drawplatform() {
    rect(this.x, this.y, l, -h);
  }
}

ArrayList<Platform> platforms;

class Man {
  float x;
  float y;
  float h, w;
  float vx = 0;
  float vy = 0;
  boolean airTime = true;
  
  float left, right, up, down;

  Man(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void doframe() {
    left = 0;
    right = width;
    up = height;
    down = 0;
    
    for (Platform p: platforms) {
      /*float l = p.distanceLeft(this);
      float r = p.distanceRight(this);
      float u = p.distanceUp(this);
      float d = p.distanceDown(this);
      
      println(l, r, u, d);
      
      if (u > p.h & u > -p.h - 200) {
        if (l > 0) {
          if (p.x < right) {
            right = p.x;
          }
        } else {
          if (p.x + p.l > left) {
            left = p.x + p.l;
          }
        }
      } else if (l > 0 & l < p.l + 50) {
        if (u > 0) {
          if (p.x < down) {
            down = p.x;
          }
        } else {
          if (p.x - p.h < up) {
            up = p.x - p.h;
          }
        }
      }
    
      println(left, right, up, down);*/
    
      if (this.y < p.y & this.y > p.y - p.h - this.h) {
        if (this.x - 5 < p.x - this.w) {
          if (p.x < right) {
            right = p.x;
          }
        } else if (this.x + 5 > p.x + p.l) {
          if (p.x + p.l > left) {
            left = p.x + p.l;
          }
        }
      }
      
      if (this.x > p.x - this.w & this.x < p.x + p.l) {
        if (this.y > p.y - 5) {
          if (p.y > down) {
            down = p.y;
          } 
        } else if (this.y + this.h < p.y - p.h) {
          if (p.y - p.h < up) {
            up = p.y - p.h;
          }
        }
      }
    }
    
    //println(this.x, platforms.get(0).x - this.w, platforms.x);
    
    println(left, right, up, down);
    
    if (down + 50 < this.y & !airTime) {
      airTime = true;
      this.vy = 0;
    }
    
    if (keys[0]) {
      this.vx -= 0.2;
      if (this.vx < -5) {
        this.vx = -5;
      }
    } else if (keys[2]) {
      this.vx += 0.2;
      if (this.vx > 5) {
        this.vx = 5;
      }
    } else {
      if (abs(this.vx) > 0.2) {
        this.vx += -0.2 * sign(this.vx);
      } else {
        this.vx = 0;
      }
    }
    
    this.x += this.vx;
    
    if (this.vx > 0) {
      if (this.x + this.w > right) {
        this.x = right - this.w;
        this.vx = 0;
      }
    } else {
      if (this.x < left) {
        this.x = left;
        this.vx = 0;
      }
    }
    
    if (airTime) {
      this.vy -= 0.15;
      this.y += this.vy;
      if (this.vy > 0) {
        if (this.y + this.h > up) {
          this.y = up - this.h;
          this.vy = 0;
        }
      } else {
        if (this.y < down) {
          this.y = down;
          this.vy = 0;
          airTime = false;
        }
      }
      
    } else if (keys[1]) {
      airTime = true;
      this.vy = 10;
    }

    
  }
  
  void drawman() {
    rect(this.x, this.y, this.w, this.h);
  }
}

Man man;

void setup() {
  size(1500, 800);
  
  man = new Man(width / 2, 50, 50, 200);
  
  platforms = new ArrayList<Platform>();
  
  platforms.add(new Platform(0, 300, 200, 50));
  platforms.add(new Platform(width / 2 - 100, 350, 200, 50));
  platforms.add(new Platform(0, 300, 200, 50));
  
  keys = new boolean[]{false, false, false};
}

void keyPressed() {
  switch (keyCode) {
    case RIGHT:
      keys[0] = true;
      break;
    case UP:
      keys[1] = true;
      break;
    case LEFT:
      keys[2] = true;
      break;
    case 'R':
      setup();
      break;
  }
}

void keyReleased() {
  switch (keyCode) {
    case RIGHT:
      keys[0] = false;
      break;
    case UP:
      keys[1] = false;
      break;
    case LEFT:
      keys[2] = false;
      break;
  }
}

void draw() {
  pushMatrix();
  translate(width, height);
  rotate(radians(180));
  
  background(0);
  fill(255);
  stroke(255);
  man.doframe();
  man.drawman();
  
  for (Platform p: platforms) {
    p.drawplatform();
  }
  
  popMatrix();
  
}
