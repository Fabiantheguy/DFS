
boolean netThrown = false;
boolean netLanded = false;
float netX, netY, netStartX, netStartY;
float boatX = 300, boatY = 400;
float boatTargetX = boatX;
boolean movingLeft = false, movingRight = false;
int netMax = 4; // Amount of cans that fit in the net
float boatSpeed = .8; // Boat's movement speed

// Net movement variables
float netDirX, netDirY;
float netSpeed = 5;
float netDistance = 0;
float maxNetSize = 50; // Max size of the net
float netSize; // Actual size of the net
float targetDistance; // The actual distance the net will travel
float maxRange = 150;  // Maximum net throwing distance
boolean isRetracting = false;

// Velocity-based movement for smooth retraction
float netVelocityX = 0;
float netVelocityY = 0;
float deceleration = 0.95; // Gradual slowdown effect
float fallSpeed = 0.5; // Speed at which the net falls down

void boatSetup() {
  boatX = width / 2;
  boatY = height - 500;
  boatTargetX = boatX; // Set initial target to starting position
}

void boatDraw() {
  move();
  boatX = lerp(boatX, boatTargetX, 0.1);
  drawBoat();
  retract();

  // Track the distance between the boat and the net
  float distanceToBoat = dist(netX, netY, boatX, boatY);
  if (netThrown) {
    if (!netLanded) {
      // Move net forward and shrink it
      if (netDistance < targetDistance) {
        netX += netDirX * netSpeed;
        netY += netDirY * netSpeed;
        netDistance += netSpeed;
        netSize = map(netDistance, 0, targetDistance, 20, maxNetSize);

        // Constrain net's position within river bounds while being thrown
        constrainNetPosition();
      } else {
        netLanded = true;
      }
    } else {
      if (distanceToBoat > maxRange) {
        // Allow net to drift smoothly toward the boat
        netVelocityX += (boatX - netX) * 0.002;
        if (netY < boatY) {
          netVelocityY += (boatY - netY) * 0.002;
        }
      } else {
        // Let the net slowly fall down until it reaches max range
        netY += fallSpeed;
      }

      // Apply velocity and gradual slowdown
      netVelocityX *= deceleration;
      netVelocityY *= deceleration;
      netX += netVelocityX;
      netY += netVelocityY;

      // Constrain net's position during retraction
      constrainNetPosition();

      // Once net reaches the boat, reset everything for a new throw
      if (distanceToBoat < 50) {
        netLanded = false; // Ready for a new throw
        netThrown = false;
        isRetracting = false;
        netSize = 0; // Reset net size
        collectCans();  // Collect cans once the net collides with the boat
      }
    }

    drawNet();
  }


  // Draw collected cans count at the top right
  displayCollectedCans();
}


class MoveLeftCommand implements Command {
  public void execute() {
    movingLeft = true;
  }
}

class MoveRightCommand implements Command {
  public void execute() {
    movingRight = true;
  }
}

class StopMoveLeftCommand implements Command {
  public void execute() {
    movingLeft = false;
  }
}

class StopMoveRightCommand implements Command {
  public void execute() {
    movingRight = false;
  }
}

class ThrowNetCommand implements Command {
  public void execute() {
    if (!netThrown) {
      netThrown = true;
      netX = boatX;
      netY = boatY;
      netStartX = boatX;
      netStartY = boatY;
      netDistance = 0;
      netSize = 50;

      float dirX = mouseX - boatX;
      float dirY = mouseY - boatY;
      float length = sqrt(dirX * dirX + dirY * dirY);
      targetDistance = min(length, maxRange);
      netDirX = dirX / length;
      netDirY = dirY / length;

      // Constrain net's starting X position within river bounds
      float xOffset = sin((netY + riverOffset) * waveFrequency) * waveAmplitude;
      float leftBound = riverX + xOffset;  // Right boundary now left
      float rightBound = riverX + xOffset + riverWidth;  // Left boundary now right
      netX = constrain(netX, leftBound + 10, rightBound - 10);
    }
    if (netThrown && netLanded) {
      isRetracting = true;
    }
  }
}


void move() {
  if (movingLeft && !gamePaused) {
    boatTargetX -= boatSpeed;
  }
  if (movingRight && !gamePaused) {
    boatTargetX += boatSpeed;
  }

  // Get river boundaries at the boat's Y position
  float xOffset = sin((boatY + riverOffset) * waveFrequency) * waveAmplitude;
  float leftBound = riverX + xOffset;
  float rightBound = riverX + xOffset + riverWidth;
  boatTargetX = constrain(boatTargetX, leftBound + 25, rightBound - 25);
}

void drawBoat() {
  if (!gamePaused) {
    fill(139, 69, 19);
    stroke(200, 50, 10);
    strokeWeight(2);
    float w = 40;
    float h = 60;

    beginShape();
    vertex(boatX - w / 2, boatY + h / 2);
    vertex(boatX + w / 2, boatY + h / 2);
    vertex(boatX + w * 0.7 / 2, boatY - h / 2);
    vertex(boatX - w * 0.7 / 2, boatY - h / 2);
    endShape(CLOSE);
  }
}

void boatMousePressed() {
  if (!netThrown && !gamePaused) {
    netThrown = true;
    netX = boatX;
    netY = boatY;
    netStartX = boatX;
    netStartY = boatY;
    netDistance = 0;
    netSize = 50;

    float dirX = mouseX - boatX;
    float dirY = mouseY - boatY;
    float length = sqrt(dirX * dirX + dirY * dirY);
    targetDistance = min(length, maxRange);
    netDirX = dirX / length;
    netDirY = dirY / length;
  }
  if (netThrown && netLanded) {
    isRetracting = true;
  }
}

void retract() {
  if (isRetracting) {
    netVelocityX += (boatX - netX) * 0.002;
    netVelocityY += (boatY - netY) * 0.002;
    netVelocityX *= deceleration;
    netVelocityY *= deceleration;
    netX += netVelocityX;
    netY += netVelocityY;
  }
}

// Track the number of cans in the net

void collectCans() {
  // When the net reaches the boat, check for can collection
  for (int i = cansInNet - 1; i >= 0; i--) {
    Can can = cans.get(i);
    cansInNet = 0;  // Increment the number of cans in the net
    totalCansCollected++;  // Increment the total cans collected
  }
}
// Track the number of cans in the net

void drawNet() {
  stroke(255);
  fill(200);
  strokeWeight(2);

  // Draw the line connecting the boat and the net
  line(boatX, boatY, netX, netY);

  // Draw the net's center circle
  ellipse(netX, netY, netSize, netSize);

  // Draw the 4 slices of the net, darken based on cansInNet
  for (int i = 0; i < netMax; i++) {
    // Calculate the angle for each slice
    float startAngle = TWO_PI / netMax * i;
    float endAngle = TWO_PI / netMax * (i + 1);

    // If this slice is filled, darken it
    if (i < cansInNet) {
      fill(150);  // Darker color for filled slices
    } else {
      fill(200, 200, 200);  // Lighter color for empty slices
    }

    // Draw the slice as a pie wedge
    arc(netX, netY, netSize, netSize, startAngle, endAngle, PIE);
  }

  // Draw the lines connecting the center to the corners
  for (int i = 0; i < netMax; i++) {
    float angle = TWO_PI / netMax * i;
    float x = netX + cos(angle) * netSize / 2;
    float y = netY + sin(angle) * netSize / 2;
    line(netX, netY, x, y);
  }
}




// Function to constrain the net's X position within the river bounds
void constrainNetPosition() {
  // Get the current offset based on the net's Y position to account for wave effects
  float xOffset = sin((netY + riverOffset) * waveFrequency) * waveAmplitude;
  float leftBound = riverX + xOffset;  // Left boundary of the river
  float rightBound = riverX + xOffset + riverWidth;  // Right boundary of the river

  // Constrain the net’s X position within the calculated bounds
  netX = constrain(netX, leftBound + 10, rightBound - 10);
}
