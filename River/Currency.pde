float[] textPosX = {255, 1660, 255, 1600}; // X positon of the text
float[] textPosY = {150, 150, 450, 450}; // Y positon of the text
String[] upgrades = {"Can Value", "Net Range", "Boat Speed", "Net Maximum"}; // upgrade names

float[] buttonPos = {100, 1500}; // X positon of the button
PVector buttonSize; // width and length of button
PFont buttonFont; // font of the text
color buttonColor, fontColor; // colour of the button and the font

  
void currencySetup(){
  buttonFont = loadFont("Verdana-Bold-30.vlw");
  textAlign(CENTER, CENTER);  
  textFont(buttonFont);
  buttonSize = new PVector(320.0, 140.0);
  buttonColor = #000000;
  fontColor = #FFFFFF;
}



 

    

    

void currencyDraw(){
  noStroke();
  fill(buttonColor);
  for(int i = 0; i < buttonPos.length; i++){
    rect(buttonPos[i], 100, buttonSize.x, buttonSize.y);
    rect(buttonPos[i], 400, buttonSize.x, buttonSize.y);
  }
  
  fill(fontColor);
  for(int i = 2; i < upgrades.length; i++){
    text(upgrades[i % 2], textPosX[i % 2], textPosY[i]);
    text(upgrades[i], textPosX[i % 2], textPosY[i % 2]);
    text("Cost: " + 5, textPosX[i % 2], textPosY[i] + 50);
    text("Cost: " + 5, textPosX[i % 2], textPosY[i % 2] + 50);
  }
}
        
        
        
