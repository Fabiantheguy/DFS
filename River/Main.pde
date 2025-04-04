

void settings() {
  fullScreen(); // Set the game to full-screen mode
}

void setup() {
    riverSetup();
    boatSetup();
    inputHandler.setMousePressCommand(new ThrowNetCommand());
    riverSetup();
    boatSetup();
    currencySetup();
}

void draw() {
  
  riverDraw();
  canDraw();
  boatDraw();
  checkpointDraw();
  if (gamePaused) {
    currencyDraw();
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {      
    inputHandler.handleMousePress();
    boatMousePressed();
  if (gamePaused && mouseX > width / 2 - 50 && mouseX < width / 2 + 50 && mouseY > height / 2 - 25 && mouseY < height / 2 + 25) {
      resetGame();  // Reset the game to continue at the river
    }
  }
 
  currencyMousePressed();
}

void mouseReleased() {
}

void mouseClicked(){
}

void keyPressed() {
    if (key == 'a' || key == 'A') {
    movingLeft = true;
  }

  if (key == 'd' || key == 'D') {
    movingRight = true;
  }
    inputHandler.handleKeyPress(key);
}

void keyReleased() {
    if (key == 'a' || key == 'A') {
    movingLeft = false;
  }

  if (key == 'd' || key == 'D') {
    movingRight = false;
  }
    inputHandler.handleKeyRelease(key);
}

interface Command {
    void execute();
}

InputHandler inputHandler = new InputHandler();

class InputHandler {
    private HashMap<Character, Command> keyPressCommands = new HashMap<>();
    private HashMap<Character, Command> keyReleaseCommands = new HashMap<>();
    private Command mousePressCommand;

    public InputHandler() {
        keyPressCommands.put('a', new MoveLeftCommand());
        keyPressCommands.put('A', new MoveLeftCommand());
        keyPressCommands.put('d', new MoveRightCommand());
        keyPressCommands.put('D', new MoveRightCommand());

        keyReleaseCommands.put('a', new StopMoveLeftCommand());
        keyReleaseCommands.put('A', new StopMoveLeftCommand());
        keyReleaseCommands.put('d', new StopMoveRightCommand());
        keyReleaseCommands.put('D', new StopMoveRightCommand());
    }

    public void handleKeyPress(char key) {
        if (keyPressCommands.containsKey(key)) {
            keyPressCommands.get(key).execute();
        }
    }

    public void handleKeyRelease(char key) {
        if (keyReleaseCommands.containsKey(key)) {
            keyReleaseCommands.get(key).execute();
        }
    }

    public void handleMousePress() {
        if (mousePressCommand != null) {
            mousePressCommand.execute();
        }
    }

    public void setMousePressCommand(Command command) {
        this.mousePressCommand = command;
    }
}
