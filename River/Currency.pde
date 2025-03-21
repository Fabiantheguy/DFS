float[] textPosX = {255, 1660, 255, 1600}; // X positon of the text
float[] textPosY = {150, 150, 450, 450}; // Y positon of the text
String[] upgrades = {"Boat Speed", "Net Range", "Net Maximum", "Can Value"}; // upgrade names

float[] buttonPos = {100, 1500}; // X positon of the button
PVector buttonSize; // width and length of button
PFont buttonFont; // font of the text
color buttonColor, fontColor; // colour of the button and the font

int[] Upgrades = {5, 10, 20, 30}; // cost for net upgrades


boatUpgrade bu;
netRangeUpgrade nr;
netMaxUpgrade nm;
canUpgrade cu;

//Subclass Sandbox Pattern for Upgrades
abstract class upgradesPurchased {
  
  float scale = 1.3; // how much the upgrades 
  
 abstract void upgradeStats();
   
}


class boatUpgrade extends upgradesPurchased { //<>//
  

  
  void upgradeStats() {
    boatSpeed *= scale;
    Upgrades[0] *= scale;
  }
  
}

class netRangeUpgrade extends upgradesPurchased {
  
  void upgradeStats() {
    maxRange *= scale;
    Upgrades[1] *= scale;     
  }
}

class netMaxUpgrade extends upgradesPurchased {
  
  void upgradeStats() {
    netMax *= scale;
    Upgrades[2] *= scale;
  }
}

class canUpgrade extends upgradesPurchased {
  
  void upgradeStats(){
    addValue += scale;
    Upgrades[3] *= scale;
  }
  
}

//Singleton for money lossed after making a purchase of an upgrade


// Command Pattern for Purchase History
class purchaseHistory {
}


void currencySetup() {
  buttonFont = loadFont("Verdana-Bold-30.vlw"); // Cute Font :3
  textAlign(CENTER, CENTER); // makes text spawn in the middle of the coordinates
  textFont(buttonFont); // every text is in this amazing font
  buttonSize = new PVector(320.0, 140.0); // all buttons are the same size
  buttonColor = #000000; // boring black
  fontColor = #FFFFFF; // boring white
  bu = new boatUpgrade(); // increases the speed of the boat
  nr = new netRangeUpgrade(); // increased the range the net is thrown
  nm = new netMaxUpgrade(); // maximum net capicity upgrade
  cu = new canUpgrade(); // Value of each can you collected
}

void currencyDraw() {
  noStroke();
  
  // a rectangle spawns at these amazing spots
  for (int i = 0; i < buttonPos.length; i++) {
    if(!gamePaused){
      fill(125);
    } else if(gamePaused){
      fill(buttonColor);
    }
    rect(buttonPos[i], 100, buttonSize.x, buttonSize.y);
    rect(buttonPos[i], 400, buttonSize.x, buttonSize.y);
  }

  // allows text to not overlap on all the buttons
  for (int i = 2; i < upgrades.length; i++) {
    fill(fontColor);
    text(upgrades[i], textPosX[i % 2] + 50, textPosY[i]);
    text(upgrades[i % 2], textPosX[i % 2] + 50, textPosY[i % 2]);
    text("Cost: " + Upgrades[i], textPosX[i % 2] + 50, textPosY[i] + 50);
    text("Cost: " + Upgrades[i % 2], textPosX[i % 2] + 50, textPosY[i % 2] + 50);
    textSize(20);
    text("Collected Cans: " + totalCansCollected, width - 125, 20);
  }
}

void currencyMousePressed() {
  
  // collisions for all the buttons 
  if (mouseX > 100 && mouseX < 415 && mouseY > 100 && mouseY < 240 && gamePaused == true && totalCansCollected >= Upgrades[0]) {
    bu.upgradeStats(); //<>//
    totalCansCollected -= Upgrades[0];
  }
  
  if (mouseX > 1500 && mouseX < 1830 && mouseY > 100 && mouseY < 240 && gamePaused == true && totalCansCollected >= Upgrades[1]) {
    nr.upgradeStats();
    totalCansCollected -= Upgrades[1];
  }
  if (mouseX > 100 && mouseX < 415 && mouseY > 400 && mouseY < 530 && gamePaused == true && totalCansCollected >= Upgrades[2]) {
    nm.upgradeStats();
    totalCansCollected -= Upgrades[2];
  }
  
  if (mouseX > 1500 && mouseX < 1830 && mouseY > 400 && mouseY < 530 && gamePaused == true && totalCansCollected >= Upgrades[3]) {
    cu.upgradeStats();
    totalCansCollected -= Upgrades[3];
  }
}
