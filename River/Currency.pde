float[] buttonPos = {100, 400, 1500}; // positon of the button
PVector buttonSize; // width and length of button
PFont buttonFont; // font of the text
color buttonColor, fontColor; // colour of the button and the 

void currencySetup(){
  buttonFont = loadFont("Verdana-Bold-30.vlw");
  textAlign(CENTER, CENTER);  
  textFont(buttonFont);
  buttonSize = new PVector(320.0, 140.0);

 
}



 

    

    

void currencyDraw(){
  noStroke();
  fill(buttonColor);
  rect(100, 100, 320, 140);
  rect(1500, 100, 320, 140);
  rect(100, 400, 320, 140);
  rect(1500, 400, 320, 140);
  fill(#FFFFFF);
  text("Boat Speed", 255, 150);
  text("Cost: " + 5, 255, 200);
  text("Net Range", 1660, 150);
  text("Cost: " + 5, 1660, 200);
  text("Can Value", 255, 450);
  text("Cost: " + 5, 255, 500);
  text("Net Maximum", 1660, 450);
  text("Cost: " + 5, 1660, 500);
}
        
        
        
