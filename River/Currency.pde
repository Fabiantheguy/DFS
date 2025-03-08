float[] textPosX = {255, 1660, 255, 1600}; // X positon of the text
float[] textPosY = {150, 150, 450, 450}; // Y positon of the text
String[] upgrades = {"Boat Speed", "Net Range", "Net Maximum", "Can Value"}; // upgrade names

float[] buttonPos = {100, 1500}; // X positon of the button
PVector buttonSize; // width and length of button
PFont buttonFont; // font of the text
color buttonColor, fontColor; // colour of the button and the font

int money = 100; // currency for collecting cans
int[] netUpgrades = {15, 20, 15, 20};
int[] canBoatUpgrades = {5, 10, 5, 10};

void currencySetup(){
  buttonFont = loadFont("Verdana-Bold-30.vlw"); // Cute Font :3
  textAlign(CENTER, CENTER); // makes text spawn in the middle of the coordinates
  textFont(buttonFont); // every text is in this amazing font
  buttonSize = new PVector(320.0, 140.0); // all buttons are the same size 
  buttonColor = #000000; // boring black
  fontColor = #FFFFFF; // boring white
}

void currencyDraw(){
  noStroke();
  // a rectangle spawns at these amazing spots
  for(int i = 0; i < buttonPos.length; i++){ 
    fill(buttonColor);
    rect(buttonPos[i], 100, buttonSize.x, buttonSize.y);
    rect(buttonPos[i], 400, buttonSize.x, buttonSize.y);
  }
  
  fill(fontColor);
  // allows text to not overlap on all the buttons
  for(int i = 2; i < upgrades.length; i++){
    fill(fontColor);
    text(upgrades[i], textPosX[i % 2], textPosY[i]);
    text(upgrades[i % 2], textPosX[i % 2], textPosY[i % 2]);
    text("Cost: " + netUpgrades[i], textPosX[i % 2], textPosY[i] + 50);
    text("Cost: " + canBoatUpgrades[i], textPosX[i % 2], textPosY[i % 2] + 50);
  }
}

void currencyMousePressed(){
  for(int i = 0; i < buttonPos.length; i++){
    if(mouseX > buttonPos[i] && 
    mouseX < 100 &&
    mouseX < 100 &&
    mouseY > buttonSize.x && 
    mouseY < buttonSize.y &&
    money <= netUpgrades[i] && 
    money >= canBoatUpgrades[i]){
      buttonColor = #00ff00;
    }
    
  }
}
        
        
