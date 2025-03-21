float[] textPosX = {255, 1660, 255, 1600}; // X positon of the text
float[] textPosY = {150, 150, 450, 450}; // Y positon of the text
String[] upgrades = {"Boat Speed", "Net Range", "Net Maximum", "Can Value"}; // upgrade names

float[] buttonPos = {100, 1500}; // X positon of the button
PVector buttonSize; // width and length of button
PFont buttonFont; // font of the text
color buttonColor, fontColor; // colour of the button and the font

int money = 100; // currency for collecting cans
int[] netUpgrades = {15, 20, 15, 20}; // cost for net upgrades
int[] canBoatUpgrades = {5, 10, 5, 10}; // cost for can and boat upgrades

boatUpgrade bu;
netRangeUpgrade nr;
netMaxUpgrade nm;


//Subclass Sandbox Pattern for Upgrades
abstract class upgradesPurchased {
  
  float scale = 1.3; // how much the upgrades 
  
 abstract void upgradeStats();
   
}


class boatUpgrade extends upgradesPurchased { //<>//
  

  
  void upgradeStats() {
    boatSpeed *= scale;
    money -= canBoatUpgrades[0];
    canBoatUpgrades[0] *= 1.2;     
  }
  
}

class netRangeUpgrade extends upgradesPurchased {
  
  void upgradeStats() {
    maxRange *= scale;
     
    }
}

class netMaxUpgrade extends upgradesPurchased {
  
  void upgradeStats() {
    netMax *= scale;
  }
}

class canUpgrade extends upgradesPurchased {
  
  void upgradeStats(){
  }
  
}

// Singleton for money lossed after making a purchase of an upgrade
//class moneyLoss {
  
//  private static moneyLoss instance;
  
//  private moneyLoss() {
//  }
  
//}

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
  
}

void currencyDraw() {
  noStroke();
  println(boatSpeed);
  
  // a rectangle spawns at these amazing spots
  for (int i = 0; i < buttonPos.length; i++) {
    fill(buttonColor);
    rect(buttonPos[i], 100, buttonSize.x, buttonSize.y);
    rect(buttonPos[i], 400, buttonSize.x, buttonSize.y);
  }

  // allows text to not overlap on all the buttons
  for (int i = 2; i < upgrades.length; i++) {
    fill(fontColor);
    text(upgrades[i], textPosX[i % 2], textPosY[i]);
    text(upgrades[i % 2], textPosX[i % 2], textPosY[i % 2]);
    text("Cost: " + netUpgrades[i], textPosX[i % 2], textPosY[i] + 50);
    text("Cost: " + canBoatUpgrades[0], textPosX[i % 2], textPosY[i % 2] + 50);
    textSize(20);
    text("Collected Cans: " + money, width - 125, 20);
  }
}

void currencyMousePressed() {
  if (mouseX > 100 && mouseX < 415 && mouseY > 100 && mouseY < 240 && gamePaused == true && money >= canBoatUpgrades[0]) {
    nm.upgradeStats(); //<>//
  }
}
