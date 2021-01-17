PImage img; 

void setup() {
  //size(1080, 1080);
  fullScreen();
  img = loadImage("doof.PNG");
  img.resize(height, height);
  rectMode(CENTER);
}

void draw() {
  background(255);
  //image(img, 0, 0);
  fill(0);
  noStroke();
  float tiles = width/12;
  float tileSize = width/tiles;
  translate(tileSize/2, tileSize/2);
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x*tileSize), int(y*tileSize));
      float size = constrain(map(brightness(c), 0, 4, 0, tileSize), 0, 10);    
      ellipse(x*tileSize, y*tileSize, size, size);
    }
  }
}
