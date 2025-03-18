// River variables
float riverX, riverWidth = 400;
float riverSpeed = 2;
float riverOffset = 0;
float waveFrequency = 0.005;
float waveAmplitude = 100;
boolean gamePaused = false;  // Flag to check if the game is paused
boolean showCheckpoint = false;  // Flag to show the bar after 1 second
int startTime;  // Variable to store the start time
float checkPointTimer = 10000; // Timer for the checkpoint to appear
float checkpointY = 0;  // Initial Y position for the bar

void riverSetup() {
  riverX = width / 2 - riverWidth / 2;
  startTime = millis();  // Store the start time when setup runs
}

void riverDraw() {
  if (gamePaused) {
    // Display the paused screen with return button
    displayPauseScreen();
    return;  // Stop drawing the river when the game is paused
  }

  background(50, 255, 50); // Green background
  noStroke();
  fill(30, 100, 200);
  riverOffset -= riverSpeed;  // Reverse the flow direction by subtracting

  beginShape();
  for (int y = -100000; y <= height; y += 5) { // Smaller increments for a smoother curve
    float xOffset = sin((y + riverOffset) * waveFrequency) * waveAmplitude;
    float leftX = riverX + xOffset + riverWidth; // Reverse direction for left side
    curveVertex(leftX, y);
  }
  for (int y = height; y >= 0; y -= 5) {
    float xOffset = sin((y + riverOffset) * waveFrequency) * waveAmplitude;
    float rightX = riverX + xOffset; // Reverse direction for right side
    curveVertex(rightX, y);
  }
  endShape(CLOSE);
  
  drawCheckpoint();
}

void drawCheckpoint() {
  if (millis() - startTime > checkPointTimer) { 
    showCheckpoint = true;  
  }

  if (showCheckpoint && !gamePaused) {
    fill(139, 69, 19);  // Brown color for the checkpoint bar
    float checkpointWidth = width;
    checkpointY += 1;  
    rect(0, -100 + checkpointY, checkpointWidth, 150);
  }
  
  // Check for collision with checkpoint
  if (boatY + 60 >= -100 + checkpointY && boatY <= -100 + checkpointY + 150 && !gamePaused) {
    gamePaused = true;  // Pause the game
    netThrown = false;  // Disable net throwing
  }
}

void displayPauseScreen() {
  // Display a brown screen indicating the game is paused
  fill(139, 69, 19, 150);  // Semi-transparent brown
  rect(0, 0, width, height);

  // Draw "Resume" button
  fill(255);
  rect(width / 2 - 75, height / 2 - 30, 150, 60);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Resume", width / 2, height / 2);

  // If mouse is clicked within the "Resume" button
  if (mousePressed && mouseX > width / 2 - 75 && mouseX < width / 2 + 75 && mouseY > height / 2 - 30 && mouseY < height / 2 + 30) {
    resumeGame();
  }
}

void resumeGame() {
  // Reset the game state when returning from pause
  gamePaused = false;  // Unpause the game
  showCheckpoint = false;  // Hide the checkpoint
  checkpointY = 0;  // Reset checkpoint position
  startTime = millis();  // Reset the timer
}

void resetGame() {
  gamePaused = false;
  boatX = width / 2;
  boatY = height - 500;
  boatTargetX = boatX;
  netThrown = false;
  netLanded = false;
  startTime = millis();  // Restart checkpoint timer
}
