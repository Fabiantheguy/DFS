float[] textPosX = {255, 1660, 255, 1600}; // X positon of the text
float[] textPosY = {150, 150, 450, 450}; // Y positon of the text
String[] upgrades = {"Boat Speed", "Net Range", "Net Maximum", "Can Value"}; // upgrade names

float[] buttonPos = {100, 1500}; // X positon of the button
PVector buttonSize; // width and length of button
PFont buttonFont; // font of the text
color buttonColor, fontColor; // colour of the button and the font

int[] Upgrades = {5, 10, 20, 25}; // cost for net upgrades


boatUpgrade boatUpgrade;
netRangeUpgrade netRange;
netMaxUpgrade netMaximum;
canUpgrade canValue;

//Subclass Sandbox Pattern for Upgrades
abstract class upgradesPurchased {
  
  float scale = 1.3; // how much the upgrades 
  
 abstract void upgradeStats();
   
}


class boatUpgrade extends upgradesPurchased { //<>//
  

  
  void upgradeStats() {
    boatSpeed *= scale;
    Upgrades[0] *= scale;
    totalCansCollected -= Upgrades[0];
  }
  
}

class netRangeUpgrade extends upgradesPurchased {
  
  void upgradeStats() {
    maxRange *= scale;
    Upgrades[1] *= scale;     
    totalCansCollected -= Upgrades[1];    
  }
}

class netMaxUpgrade extends upgradesPurchased {
  
  void upgradeStats() {
    netMax *= scale;
    Upgrades[2] *= scale;
    totalCansCollected -= Upgrades[2];    
  }
}

class canUpgrade extends upgradesPurchased {
  
  void upgradeStats(){
    addValue += scale;
    Upgrades[3] *= scale;
    totalCansCollected -= Upgrades[3];    
  }
  
}

// Command Pattern for instance of purchasing an upgradea
class purchaseCommand {
  
  upgradesPurchased upgrade;
  
  purchaseCommand(upgradesPurchased upgrade) {
    this.upgrade = upgrade; // assigning an object from the upgrade class to this upgrade field :3
  }
  
  void execute() {
    upgrade.upgradeStats(); // actually doing the purchase
  }
  
}


void currencySetup() {
  buttonFont = loadFont("Verdana-Bold-30.vlw"); // Cute Font :3
  textAlign(CENTER, CENTER); // makes text spawn in the middle of the coordinates
  textFont(buttonFont); // every text is in this amazing font
  buttonSize = new PVector(320.0, 140.0); // all buttons are the same size
  buttonColor = #000000; // boring black
  fontColor = #FFFFFF; // boring white
  boatUpgrade = new boatUpgrade(); // increases the speed of the boat
  netRange = new netRangeUpgrade(); // increased the range the net is thrown
  netMaximum = new netMaxUpgrade(); // maximum net capicity upgrade
  canValue = new canUpgrade(); // Value of each can you collected
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
  }
}


void currencyMousePressed() {
  
  // collisions for all the buttons 
  if (mouseX > 100 && mouseX < 415 && mouseY > 100 && mouseY < 240 && gamePaused == true && totalCansCollected >= Upgrades[0]) {
    purchaseCommand purchase = new purchaseCommand(boatUpgrade);
    purchase.execute(); //<>//
  }
  
  if (mouseX > 1500 && mouseX < 1830 && mouseY > 100 && mouseY < 240 && gamePaused == true && totalCansCollected >= Upgrades[1]) {
    purchaseCommand purchase = new purchaseCommand(netRange);
    purchase.execute();
  }
  if (mouseX > 100 && mouseX < 415 && mouseY > 400 && mouseY < 530 && gamePaused == true && totalCansCollected >= Upgrades[2]) {
    purchaseCommand purchase = new purchaseCommand(netMaximum);
    purchase.execute();
  }
  
  if (mouseX > 1500 && mouseX < 1830 && mouseY > 400 && mouseY < 530 && gamePaused == true && totalCansCollected >= Upgrades[3]) {
    purchaseCommand purchase = new purchaseCommand(canValue);
    purchase.execute();
  }
}
