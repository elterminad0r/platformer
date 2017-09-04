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


