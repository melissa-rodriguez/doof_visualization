import controlP5.*;

ControlP5 cp5;
boolean buttonState = false;


RadioButton r1, r2;
int buttonNumber;
int a;

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(r1)) {
    buttonNumber = int(theEvent.getGroup().getValue());
  }
  
}


void radioButton(int a) {
  if(a == -1){
    buttonState = false;
  }
  else{
   buttonState = true; 
  }
}

void createButtons(){
  int buttonAmount = 5;
  int spacing = 5;
  int buttonWidth = (width/(5*buttonAmount));
  int buttonHeight = (height/(5*buttonAmount));
  cp5 = new ControlP5(this);
  r1 = cp5.addRadioButton("radioButton")
    .setPosition(width*0.01, height/25)
    .setSize(buttonWidth, buttonHeight)
    .setSpacingRow(spacing)
    .addItem("", 1)
    .addItem(" ", 2)
    .addItem("   ", 3)
    .addItem("    ", 4)
    .addItem("     ", 5)
    ;
}

void buttonOutline() {
  int buttonAmount = 5;
  int spacing = 5;
  int buttonWidth = (width/(5*buttonAmount));
  int buttonHeight = (height/(5*buttonAmount));

  push();
  rectMode(CORNER);
  stroke(61, 173, 242);
  noFill();
  for (int y = height/25; y < (buttonAmount*(spacing + buttonHeight)); y+= buttonHeight + spacing) {
    rect(width*0.01, y, buttonWidth, buttonHeight);
  }
  pop();
}

void showLabels() {
  int buttonAmount = 5;
  int spacing = 5;
  int buttonWidth = (width/(5*buttonAmount));
  int buttonHeight = (height/(5*buttonAmount));

  float labelX = (width*0.01)+buttonWidth + 5*spacing;
  float labelY = height/25 + buttonHeight/2;

  pushMatrix();
  textFont(sans);
  textSize(45);
  textAlign(LEFT, CENTER);
  rectMode(CORNER);

  if (buttonNumber == 1) {    
    fill(255);
    text("BEHOLD, THE INATORS", labelX, labelY);
    rect(width*0.01, height/25, buttonWidth, buttonHeight);

    fill(70, 70, 70);
    text("PERRY THE PLATYPUS", labelX, labelY+buttonHeight+spacing);
    text("TRI-STATE TAKEOVER", labelX, labelY+(2*buttonHeight)+spacing);
    text("EVIL", labelX, labelY+(3*buttonHeight)+spacing);
    text("SELF DESTRUCT", labelX, labelY+(4*buttonHeight)+spacing);
  } else if (buttonNumber == 2) {
    fill(255);
    text("PERRY THE PLATYPUS", labelX, labelY+buttonHeight+spacing);
    rect(width*0.01, height/25 + (buttonHeight + spacing), buttonWidth, buttonHeight);
    
    fill(70, 70, 70);
    text("BEHOLD, THE INATORS", labelX, labelY);
    text("TRI-STATE TAKEOVER", labelX, labelY+(2*buttonHeight)+spacing);
    text("EVIL", labelX, labelY+(3*buttonHeight)+spacing);
    text("SELF DESTRUCT", labelX, labelY+(4*buttonHeight)+spacing);
  } else if (buttonNumber == 3) {
    fill(255);
    text("TRI-STATE TAKEOVER", labelX, labelY+(2*buttonHeight)+spacing);
    rect(width*0.01, height/25 + 2*(buttonHeight + spacing), buttonWidth, buttonHeight);

    fill(70, 70, 70);
    text("BEHOLD, THE INATORS", labelX, labelY);
    text("PERRY THE PLATYPUS", labelX, labelY+buttonHeight+spacing);
    text("EVIL", labelX, labelY+(3*buttonHeight)+spacing);
    text("SELF DESTRUCT", labelX, labelY+(4*buttonHeight)+spacing);
  } else if (buttonNumber == 4) {
    fill(255);
    text("EVIL", labelX, labelY+(3*buttonHeight)+spacing);
    rect(width*0.01, height/25 + 3*(buttonHeight + spacing), buttonWidth, buttonHeight);

    fill(70, 70, 70);
    text("BEHOLD, THE INATORS", labelX, labelY);
    text("PERRY THE PLATYPUS", labelX, labelY+buttonHeight+spacing);
    text("TRI-STATE TAKEOVER", labelX, labelY+(2*buttonHeight)+spacing);
    text("SELF DESTRUCT", labelX, labelY+(4*buttonHeight)+spacing);
  } else if (buttonNumber == 5) {
    fill(255);
    text("SELF DESTRUCT", labelX, labelY+(4*buttonHeight)+spacing);
    rect(width*0.01, height/25 + 4*(buttonHeight + spacing), buttonWidth, buttonHeight);

    fill(70, 70, 70);
    text("BEHOLD, THE INATORS", labelX, labelY);
    text("PERRY THE PLATYPUS", labelX, labelY+buttonHeight+spacing);
    text("TRI-STATE TAKEOVER", labelX, labelY+(2*buttonHeight)+spacing);
    text("EVIL", labelX, labelY+(3*buttonHeight)+spacing);
  } else if (buttonState == false) {
    buttonOutline();
    fill(70, 70, 70);
    text("BEHOLD, THE INATORS", labelX, labelY);
    text("PERRY THE PLATYPUS", labelX, labelY+buttonHeight+spacing);
    text("TRI-STATE TAKEOVER", labelX, labelY+(2*buttonHeight)+spacing);
    text("EVIL", labelX, labelY+(3*buttonHeight)+spacing);
    text("SELF DESTRUCT", labelX, labelY+(4*buttonHeight)+spacing);
  }

  popMatrix();
}
