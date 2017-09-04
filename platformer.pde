boolean[] keys;

float sign(float n) {
  return n / abs(n);
}

ArrayList<Platform> platforms;

Man man;

void setup() {
  size(1500, 800);
  
  platforms = new ArrayList<Platform>();

  man = new Man(width / 2, 50, 50, 200, platforms);
  
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
