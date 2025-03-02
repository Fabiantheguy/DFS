void settings() {
  fullScreen(); // Set the game to full-screen mode
}


void setup() {
  riverSetup();
  boatSetup();
}

void draw() {
  riverDraw();
  boatDraw();
}

void mousePressed() {
  currencyMousePressed();
}

void mouseReleased() {
  boatMouseReleased();
}
