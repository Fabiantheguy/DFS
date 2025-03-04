Button b;

void settings() {
  fullScreen(); // Set the game to full-screen mode
}


void setup() {
  riverSetup();
  boatSetup();
  b = Button("type");
}

void draw() {
  riverDraw();
  boatDraw();
  b.currencyMousePressed();
}

void mousePressed() {
  //currencyMousePressed();
}

void mouseReleased() {
  boatMouseReleased();
}
