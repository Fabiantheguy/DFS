class Button{
  PVector pos;
  PVector size;
  PFont buttonFont;
  color buttonColor, fontColor;
  
  //hitboxes for button
  float left, right, bot, top;
  
  Button(String type){
    size = new PVector(320.0, 140.0);
    buttonFont = loadFont("Verdana-30.vlw");
    buttonColor = #000000;
    fontColor = #FFFFFF;
    
    switch(type) {
      case "range":
        pos = new PVector(1500.0, 100.0);
        
         
    }
  }
 

    

    
int money = 100;
void currencyMousePressed(){
  noStroke();
  fill(#000000);
  rect(100, 100, 320, 140);
  rect(1500, 100, 320, 140);
  //rect(100, 400, 320, 140);
  rect(1500, 400, 320, 140);
  fill(#FFFFFF);
  textFont(buttonFont);
  textSize(30);
  textAlign(CENTER, CENTER);
  text("Boat Speed", 255, 150);
  text("Cost: " + 5, 255, 200);
  text("Net Range", 1660, 150);
  text("Cost: " + 5, 1660, 200);
  text("Can Value", 255, 450);
  text("Cost: " + 5, 255, 500);
  text("Net Maximum", 1660, 450);
  text("Cost: " + 5, 1660, 500);
  
}        
        
        
        
  }

// Currency
