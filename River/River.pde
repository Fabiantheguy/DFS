float riverX = 100, riverWidth = 400;
float riverOffset = 0;  // Controls the vertical position of the river
float riverSpeed = 10;  // Controls how fast the river moves down

int riverSegments = 100;  // Number of segments in the river for smoother curves
float[] riverWidths = new float[riverSegments];  // Widths of each segment
PVector[] riverPaths = new PVector[riverSegments];  // Control points for the river's path

// Additional variables for gentle curve control
float lastAngle = 0;
float angleVariance = PI / 100;  // Increased angle variance for faster and more pronounced bends
int curveStart = 20;  // Start the curve earlier in the river path
float curveSpeed = 0.15;  // Controls the speed of the curve transition

void riverSetup() {
  riverX = width / 2 - riverWidth / 2;
  
  // Initialize the river control points and widths
  riverPaths[0] = new PVector(width / 2, height / 2);  // Start point of the river
  
  // Create a straight section for the start of the river (the boat's location)
  for (int i = 1; i < curveStart; i++) {
    riverPaths[i] = new PVector(riverPaths[i - 1].x, riverPaths[i - 1].y + random(0, 5));  // Keep it straight
    riverWidths[i] = random(150, 250);  // Randomize the width of the river at each point
  }
  
  // Transition into a curve after the straight part
  for (int i = curveStart; i < riverSegments; i++) {
    float angle = lastAngle + random(-angleVariance, 0);  // Only curve to the left
    float distance = random(100, 150);  // Slightly random distance to keep it from being too straight
    
    PVector lastPoint = riverPaths[i - 1];
    float x = lastPoint.x + cos(angle) * distance;
    float y = lastPoint.y + sin(angle) * distance;

    riverPaths[i] = new PVector(x, y);
    riverWidths[i] = random(150, 250);  // Randomize the width of the river at each point
    
    lastAngle = angle;  // Update the last angle for the next segment
  }
}

void riverDraw() {
  background(100, 150, 255);  // Sky color
  background(50, 255, 50);    // Ground color
  noStroke();
  fill(30, 100, 200);

  // Shift the river downward to simulate the boat moving
  riverOffset += riverSpeed;

  // Draw the rectangular start of the river
  rect(riverX, 0, riverWidth, height);

<<<<<<< Updated upstream
=======
  // Now draw the curved part of the river after the initial rectangle
  beginShape();
  for (int i = 0; i < riverSegments; i++) {
    PVector currentPoint = riverPaths[i];
    float widthAtPoint = riverWidths[i];

    // Control the curve with the previous and current points
    if (i == 0) {
      vertex(currentPoint.x - widthAtPoint / 2, currentPoint.y + riverOffset);
      vertex(currentPoint.x + widthAtPoint / 2, currentPoint.y + riverOffset);
    } else {
      PVector prevPoint = riverPaths[i - 1];
      float controlPointX = (prevPoint.x + currentPoint.x) / 2;
      float controlPointY = (prevPoint.y + currentPoint.y) / 2;

      // Use bezierVertex to create smoother curves between control points
      bezierVertex(prevPoint.x, prevPoint.y + riverOffset, controlPointX, controlPointY + riverOffset, currentPoint.x, currentPoint.y + riverOffset);
    }
  }
  
  // Close the river shape by connecting back to the last segment
  PVector lastPoint = riverPaths[riverSegments - 1];
  vertex(lastPoint.x + riverWidths[riverSegments - 1] / 2, lastPoint.y + riverOffset);
  vertex(lastPoint.x - riverWidths[riverSegments - 1] / 2, lastPoint.y + riverOffset);
  endShape(CLOSE);
}
float getRiverY(float x) {
  // Return the Y position of the river for a given X (to match the boat's Y position)
  int segment = int(map(x, riverX, riverX + riverWidth, 0, riverSegments - 1));
  return riverPaths[segment].y + riverOffset;
>>>>>>> Stashed changes
}
