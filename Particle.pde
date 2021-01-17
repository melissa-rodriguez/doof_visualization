class Particle {
  float x;
  float y;
  PVector pos;
  PVector vel;
  PVector acc;
  PVector target;
  float maxSpeed;
  float maxForce;
  float size;
  String characterLine;
  color fillCol;
  String displayText;
  //int alpha;
  String season;
  String episode;
  Particle(float tempX, float tempY, float tempSize, String tempLine) {
    x = tempX;
    y = tempY;
    pos = new PVector(tempX, tempY);
    target = new PVector(tempX, tempY);
    vel = new PVector();
    acc = new PVector();
    maxSpeed = 12;
    maxForce = 12;
    size = tempSize;
    characterLine = tempLine;
    //alpha = 70;
    fillCol = color(23, 1, 38);
    displayText = "";
    season = "";
    episode = "";
  }
  void display() {
    push();
    fill(fillCol);
    //noFill();
    //println(maxSpeed);
    //int test = int(noise(pos.x, pos.y)*255);  //use noise to map the speed of each particle?
    //stroke(test);
    
    
    if(season.length() > 0){
     int seasonNum = int(season); 
     strokeParticles(seasonNum);
    }
    ellipse(pos.x, pos.y, size, size);
    pop();
  }

  void behaviors() {
    if (buttonNumber == 1 || buttonNumber == 2 || buttonNumber == 3
      || buttonNumber == 4 || buttonState == false) {
      PVector retract = retract(target.x, target.y);
      applyForce(retract);
    } else if (buttonNumber == 5) {
      flee();
    }
  }

  void applyForce(PVector f) {
    acc.add(f);
  }

  PVector retract(float targetX, float targetY) {
    PVector tar = new PVector(targetX, targetY);
    PVector desired = PVector.sub(tar, pos);
    float distance = desired.mag();
    float speed = maxSpeed;
    if (distance < width/3) {
      speed = map(distance, 0, 100, 0, maxSpeed);
      //speed = noise(targetX, targetY)*maxSpeed;
      //speed = map(noise(desired.x, desired.y), 0, 1, 0, maxSpeed);
    }
    desired.setMag(speed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce);

    if (distance == 0) {
      vel.mult(0);
    }
    return steer;
  }

  void flee() {
    vel.add(PVector.random2D());
    vel.mult(1);
  }

  void update() {
    pos.add(vel);
    vel.add(acc);
    acc.mult(0);
  }


  void clicked(float xmouse, float ymouse) {
    //check to see if mouse is inside a circle
    float d = dist(xmouse, ymouse, x, y);

    if (d<size/2) {
      showEpisodeInfo = true;
      displayText = characterLine;
      showText = characterLine;
      showSeasonEpisode = season + episode;
      //println(displayText);
    }
  }

  void mouseHover(float xmouse, float ymouse) {
    float d = dist(xmouse, ymouse, x, y);

    if (d<size/2) {
      fillCol = color(255);
    } 
  }

  void textFilter() {
    if (buttonNumber == 1) {
      //inator
      if (characterLine.indexOf("Inator")!= -1||characterLine.indexOf("inator")!= -1) { //if the substring is inside the string
        fillCol = color(252, 176, 52);
      } else {
        fillCol = color(23, 1, 38);
      }
    } else if (buttonNumber == 2) {
      //all perry mentions
      if (characterLine.indexOf("Platypus")!= -1) { //if the substring is inside the string
        fillCol = color(242, 203, 5);
      } else {
        fillCol = color(23, 1, 38);
      }
    } else if (buttonNumber == 3) {
      //tri state area
      if (characterLine.indexOf("Tri-State")!= -1) { //if the substring is inside the string
        fillCol = color(242, 121, 143);
      } else {
        fillCol = color(23, 1, 38);
      }
    } else if (buttonNumber == 4) {
      //evil
      if (characterLine.indexOf("evil")!= -1 || characterLine.indexOf("Evil")!= -1) { //if the substring is inside the string
        fillCol = color(#91C791);
      } else {
        fillCol = color(23, 1, 38);
      }
    } else {
      fillCol = color(23, 1, 38);
    }
  }
}
