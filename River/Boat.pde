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
