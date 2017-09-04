class Man {
  float x;
  float y;
  float h, w;
  ArrayList<Platform> platforms;
  float vx = 0;
  float vy = 0;
  boolean airTime = true;
  
  float left, right, up, down;

  Man(float x, float y, float w, float h, ArrayList<Platform> platforms) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.platforms = platforms;
  }
  
  void doframe() {
    left = 0;
    right = width;
    up = height;
    down = 0;
    
    for (Platform p: platforms) {
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