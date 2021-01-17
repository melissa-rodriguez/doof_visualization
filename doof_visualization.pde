import java.io.File;
//import processing.sound.*;

//SoundFile soundFile;


PImage img;
PFont doof;
PFont sans;

//making an arraylist/class object to keep track of when particle diameters > 0 
// use a class to attach a character line to each particle
ArrayList<Particle> particleArray;

String loadFile;
String characterName;
String characterLine;
String[] characterNames= {};
String[] characterLines= {};
String[] splitLine;
String[] lines;
String[] totalLines = {};
String everyLine;
String showText = "";
String showSeasonEpisode = "0000";
String[] season = {};
String[] episode = {};

int index;
int fc;
boolean showEpisodeInfo = false;

void setup() {
  //initialize canvas
  surface.setTitle("DOOFENSHMIRTZ DATA INCORPORATED");
  fullScreen(P2D);
  
  doof = createFont("Playbill.ttf", 300);
  sans = createFont("Roboto-Regular.ttf", 50);

  img = loadImage("doof.PNG");
  img.resize(height, height);
  rectMode(CENTER);
  rectMode(CENTER);
  //--------------------------------------------------------------------------
  //import sound file
  //soundFile = new SoundFile(this, "evil_inc.mp3"); 
  

  //--------------------------------------------------------------------------
  //parse through script, get character lines

  // look in the data/csv folder
  java.io.File folder = new java.io.File(dataPath("/csv"));

  // list the files in the data folder
  String[] filenames = folder.list();

  for (int epCode = 0; epCode < filenames.length; epCode++) {
    String filenum = filenames[epCode];

    //println(filenum.trim(".csv"));
    String id = filenum.replace(".csv", "");

    lines = loadStrings("csv/" + filenum);
    ;
    for (int line = 0; line < lines.length; line++) {
      everyLine = lines[line];
      totalLines = append(totalLines, everyLine);
    }

    //String[] lines = loadStrings("csv/0111.csv");
    for (int i = 0; i<lines.length; i++) {

      //splitline.length>1 filters out all empty lines (white space/enter)
      splitLine = (lines[i].split(",", 2)); //only removes first comma that seperates name and line, not every comma

      if (splitLine.length>1) {
        characterName = splitLine[0].trim();
        characterLine = splitLine[1].trim();

        //remove quotation marks from lines
        if (characterLine.startsWith("\"")) {
          characterLine = characterLine.replace("\"", "").trim();
        }


        if (characterName.startsWith("Doof") || characterName.startsWith("Dr")) {
          //println(characterName);
          characterNames = append(characterNames, characterName);
          characterLines = append(characterLines, characterLine);
          season = append(season, id.substring(0, 2));
          episode = append(episode, id.substring(2, 4));
        }
      }
    }
  }

  //--------------------------------------------------------------------------
  // create particle rasterization
  particleArray = new ArrayList<Particle>();

  //rasterize doof image
  float tiles = (width/16.08);
  float tileSize = width/tiles;
  translate(tileSize/2, tileSize/2);
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x*tileSize), int(y*tileSize));
      float size = constrain(map(brightness(c), 0, 4, 0, tileSize), 0, 15);    
      particleArray.add(new Particle(x*tileSize, y*tileSize, size, ""));
    }
  }

  //--------------------------------------------------------------------------
  //radiobuttons
  createButtons();  
}


void draw() {
  background(23, 1, 38);
  
  
  textCanvas(showText, showSeasonEpisode);
  
  // not much customization available for label names in controlp5
  showLabels();  //in radioButton tab
  
  //if(fc == 15){
  // soundFile.play(); //play evil jingle
  //}

  for (Particle p : particleArray) {
    //if the circle is big aka a particle
    if (p.size > 1) {
      p.display(); //don't display particles with radius 0
      p.behaviors();
      p.update();
      p.textFilter();
      p.mouseHover(mouseX, mouseY); // hover over each particle
      if (index < characterLines.length) { // attach each line to each particle
        p.characterLine = characterLines[index];           
        p.season = season[index];
        p.episode = episode[index];
      }
      index += 1;
    }
  }

  //controlP5 buttons do not appear in rec() export; 
  //buttonOutline only needed for render purposes. 
  buttonOutline(); // in radioButton tab
  fc += 1;

  cursor(CROSS);
  
  //saveFrame();

  //image(doof, 0, 0);
  //rec();
  //saveFrame("sketchthis.png");
}

void mousePressed() {
  for (Particle p : particleArray) {
    p.clicked(mouseX, mouseY);
  }
}

void strokeParticles(int season){
  //new stroke color for each season
   if(season == 1){
     stroke(174, 235, 242);
   }
   else if(season == 2){
     stroke(4, 178, 217);
   }
   else if(season == 3){
     stroke(4, 119, 191);
   }
   else if(season == 4){
     stroke(3, 74, 166);
   }
}

void textCanvas(String displayText, String showSeasonEpisode) {  
  //show the line and the season and episode
  if (showEpisodeInfo == true) {
    push();
    textFont(sans);
    String s = showSeasonEpisode.substring(0, 2).replace("0", "");
    String ep = showSeasonEpisode.substring(2, 4).replace("0", "");
    showSeasonEpisode = "Season " + s + ", " + "Episode " + ep;
    
    textAlign(LEFT);
    fill(255);
    textSize(45);
    stroke(255);
    rectMode(CORNER);

    text(displayText + "\n" + "\n" + "[" + showSeasonEpisode + "]", width/2, height/25, width/2-height/25, height - height/25); //two extra paramaters make a text box for text wrapping
    pop();
  } else if (showEpisodeInfo == false || buttonState == false) {
    welcomeTitle();
  }
}


void welcomeTitle() {
  push();
  textFont(doof);
  String welcomeText = "DOOFENSHMIRTZ DATA INC.";
  textSize(250);
  fill(255);
  textAlign(LEFT, CENTER);
  rectMode(CENTER);
  text(welcomeText, width-(width/4), height/2, width/2, height/2);
  pop();
}
