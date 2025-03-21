// Can class
class Can {
  float x, y;
  float speed;
  float size = 20;  // Size of the can

  Can(float x, float y, float speed) {
    this.x = x;
    this.y = y;
    this.speed = speed;
  }

  void update() {
    // Move the can downward
    y += speed;
  }

  // Check if the can is within the net's area
  boolean checkCollision(float netX, float netY, float netSize) {
    float distanceToNet = dist(x, y, netX, netY);
    return distanceToNet < netSize;  // If within net's size, we have a collision
  }

  void display() {
    fill(150);  // Red can
    noStroke();
    beginShape();
    // PurpleCan
    strokeWeight(0);
    ellipse(x + 9, y + 27.5, 17.5, 2); 
    rect(x + 0.25, y, 17.5, 27.5); 
    ellipse(x + 9, y + 0.5, 17.5, 3.5); 
    endShape(CLOSE);
  }
}

// List to store the cans
ArrayList<Can> cans = new ArrayList<Can>();
int cansInNet = 0;  // Keep track of the number of cans in the net
int totalCansCollected = 0;  // Total cans collected over time

void constrainCanPosition(Can can) {
  float xOffset = sin((can.y + riverOffset) * waveFrequency) * waveAmplitude;
  float leftBound = riverX + xOffset;
  float rightBound = riverX + xOffset + riverWidth;

  can.x = constrain(can.x, leftBound + 10, rightBound - 10);
}

// Function to update when a can is collected in the net
void collectCan(Can can) {
  if (cansInNet < netMax) {
    // Increase the number of cans in the net
    cansInNet++;

    // Darken the corresponding section of the net
    float anglePerSection = TWO_PI / netMax;
    for (int i = 0; i < cansInNet; i++) {
      float angle = anglePerSection * i;
      float x = netX + cos(angle) * netSize / 2;
      float y = netY + sin(angle) * netSize / 2;
      fill(100, 100, 100); // Darken the section
      noStroke();
      ellipse(x, y, netSize / 3, netSize / 3); // Visual representation of a can collected
    }
    
    // Remove the can from the river after being collected
    cans.remove(can);
  }
}
float canSpawnTimer = 0;
float canSpawnInterval = 2000;  // Interval between can spawns (in milliseconds)
// Modify the can drawing behavior to prevent picking up cans if the net is full
void canDraw() {
  // Track the distance between the boat and the net
  
  for (int i = cans.size() - 1; i >= 0; i--) {
    Can can = cans.get(i);
    constrainCanPosition(can);  // Constrain can's position within the river

    if (can.checkCollision(netX, netY, netSize)) {
      // If the net is not full, collect the can
      if (cansInNet < netMax) {
        collectCan(can);
      }
    } else {
      can.update();  // Update can's position
      can.display();  // Draw the can
    }
  }

  // Spawn new cans
  if (millis() - canSpawnTimer >= canSpawnInterval) {
    canSpawnTimer = millis();  // Reset timer
    spawnCan();  // Spawn a new can
  }
}

// Function to spawn a new can at a random position
void spawnCan() {
  float canX = random(riverX, riverX + riverWidth);  // Random x position within river bounds
  float canSpeed = random(3, 6);  // Random speed for falling can
  cans.add(new Can(canX, -20, canSpeed));  // Add new can to list (starting just off screen)
}

void displayCollectedCans() {
  fill(255);
  textSize(20);
  textAlign(RIGHT, TOP);
  text("Collected Cans: " + totalCansCollected, width - 20, 20);
}
