float riverX = 100, riverWidth = 400;

void riverSetup() {
  riverX = width / 2 - riverWidth / 2;
}

void riverDraw() {
  background(100, 150, 255);
  background(50, 150, 255);
  noStroke();
  fill(30, 100, 200);
  rect(riverX, 0, riverWidth, height);
}
