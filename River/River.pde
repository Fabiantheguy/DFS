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
}

void draw() {
  background(50, 150, 255);
  move();
  drawRiver();
  

  // Smooth boat movement towards target
  boatX += (boatTargetX - boatX) * boatSpeed;
  
  drawBoat();
}
