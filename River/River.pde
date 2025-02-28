ArrayList<Obstacle> obstacles;
float boatX;
float boatY;
float boatSpeed = 0.1; // Small value for smooth movement
float boatTargetX; // Target position for the boat
float riverWidth = 300;
float riverX;
boolean movingLeft = false, movingRight = false;

void settings() {
  fullScreen(); // Set the game to full-screen mode
}

void setup() {
  boatX = width / 2;
  boatY = height - 100;
  boatTargetX = boatX; // Set initial target to starting position
  riverX = width / 2 - riverWidth / 2;
  obstacles = new ArrayList<>();
}

void draw() {
  background(50, 150, 255);
  move();
  drawRiver();
  

  // Smooth boat movement towards target
  boatX += (boatTargetX - boatX) * boatSpeed;
  
  drawBoat();
  
  // Spawn obstacles
  if (frameCount % 60 == 0) {
    obstacles.add(new Obstacle(random(riverX + 20, riverX + riverWidth - 20), -50));
  }
}

void drawRiver() {
  noStroke();
  fill(30, 100, 200);
  rect(riverX, 0, riverWidth, height);
}

void drawBoat() {
  fill(139, 69, 19); // Brown color for boat
  stroke(100, 50, 10);
  strokeWeight(2);
  
  float w = 40;
  float h = 60;
  
  beginShape();
  vertex(boatX - w / 2, boatY + h / 2);  // Bottom left
  vertex(boatX + w / 2, boatY + h / 2);  // Bottom right
  vertex(boatX + w * 0.7 / 2, boatY - h / 2);  // Top right
  vertex(boatX - w * 0.7 / 2, boatY - h / 2);  // Top left
  endShape(CLOSE);
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    movingLeft = true;
  }

  if (key == 'd' || key == 'D') {
    movingRight = true;
  }
  // Keep boat inside the river
  boatTargetX = constrain(boatTargetX, riverX + 25, riverX + riverWidth - 25);
}

void keyReleased() {
  if (key == 'a' || key == 'A') {
    movingLeft = false;
  }

  if (key == 'd' || key == 'D') {
    movingRight = false;
  }

  // Keep boat inside the river
  boatTargetX = constrain(boatTargetX, riverX + 25, riverX + riverWidth - 25);
}
void move() {
  if (movingLeft) {
    boatTargetX -= 5; // Move target left
  }
  if (movingRight) {
    boatTargetX += 5; // Move target right
  }
  boatTargetX = constrain(boatTargetX, riverX + 25, riverX + riverWidth - 25);
}
class Obstacle {
  float x, y, size;
  
  Obstacle(float x, float y) {
    this.x = x;
    this.y = y;
    this.size = 40;
  }
  
  void update() {
    y += 4;  // Speed of obstacles falling
  }
  
  void display() {
    float scaleFactor = map(y, 0, height, 0.5, 1.5); // 2.5D effect
    fill(150, 50, 50);
    ellipse(x, y, size * scaleFactor, size * scaleFactor);
  }
}
