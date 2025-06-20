import controlP5.*;
ControlP5 cp5;
Group sidebar;
boolean sidebarView = true;
Group playBar;
boolean playView = false;
Group settingsBar;
boolean settingsView = false;

Textlabel error;

PFont font;

PImage example;

float speed = 1;

PVector center = new PVector(450, 350);

int selected = 0;
PImage customCursor;
String[] cursorList = {"White", "Blue"};

StatsManager stats;
SoundManager sounds;

ArrayList<Note> notes = new ArrayList<Note>();
Table noteTable;
float songStartTime;
boolean gameActive = false;

void setup() {
  size(800, 600);
  stats = new StatsManager();
  
  font = createFont("Lexend", 20);
  cp5 = new ControlP5(this);
  sidebar = cp5.addGroup("Sidebar")
    .setPosition(0, 0)
    .setLabel("Sound Squares")
    .setSize(150, height)
    .setBackgroundColor(color(50, 50, 50, 200))
    .setBackgroundHeight(height)
    .setBarHeight(0)
  ;
  cp5.addButton("Play")
    .setPosition(25, 500)
    .setSize(100, 25)
    .moveTo(sidebar)
  ;
  cp5.addButton("Settings")
    .setPosition(25, 550)
    .setSize(100, 25)
    .moveTo(sidebar)
  ;
  
  playBar = cp5.addGroup("playBar")
    .setVisible(false)
    .setPosition(0, 0)
    .setLabel("Sound Squares")
    .setSize(150, height)
    .setBackgroundColor(color(50, 50, 50, 200))
    .setBackgroundHeight(height)
    .setBarHeight(0)
  ;
  cp5.addButton("playReturn")
    .setLabel("Return")
    .setPosition(25, 500)
    .setSize(100, 25)
    .moveTo(playBar)
  ;
  cp5.addButton("Confirm")
    .setPosition(25, 550)
    .setSize(100, 25)
    .moveTo(playBar)
  ;
  cp5.addButton("song1")
    .setLabel("Laur - A Lasting Promise")
    .setPosition(25, 450)
    .setSize(100, 25)
    .moveTo(playBar)
  ;
  cp5.addButton("song2")
    .setLabel("Komodo Dragon - Block Tales OST")
    .setPosition(25, 400)
    .setSize(100, 25)
    .moveTo(playBar)
  ;
  
  settingsBar = cp5.addGroup("settingsBar")
    .setVisible(false)
    .setPosition(0, 0)
    .setLabel("Sound Squares")
    .setSize(150, height)
    .setBackgroundColor(color(50, 50, 50, 200))
    .setBackgroundHeight(height)
    .setBarHeight(0)
  ;
  cp5.addButton("settingsReturn")
    .setLabel("Return")
    .setPosition(25, 550)
    .setSize(100, 25)
    .moveTo(settingsBar)
  ;
  cp5.addSlider("speed")
    .setPosition(25, 500)
    .setSize(100, 25)
    .setRange(0.5, 1.5)
    .setNumberOfTickMarks(5)
    .moveTo(settingsBar)
  ;
  cp5.addDropdownList("Cursor")
    .setOpen(false)
    .setPosition(25, 450)
    .setSize(100, 500)
    .setItemHeight(25)
    .setBarHeight(25)
    .addItem("White", 0)
    .addItem("Blue", 1)
    .moveTo(settingsBar)
  ;
  
  cp5.addTextlabel("label1")
    .setText("Sound")
    .setPosition(385, 50)
    .setColorValue(0xFF03FEB7)
    .setFont(createFont("Arial", 40))
  ;
  cp5.addTextlabel("label2")
    .setText("Squares")
    .setPosition(370, 100)
    .setColorValue(0xFFFF63FF)
    .setFont(createFont("Arial", 40))
  ;
  error = cp5.addTextlabel("Error")
    .setPosition(300, 550)
    .setColorValue(0xFFFF0000)
    .setFont(createFont("Arial", 30))
  ;
  
  example = loadImage("example.jpg");
  
}


void draw() {
  background(0);
  
  
  //image(example, 300, 200);
  
  float currentTime = sounds != null ? sounds.getTime() : 0;
  
  if (gameActive) {
    for (int i = notes.size() - 1; i >= 0; i--) {
      Note n = notes.get(i);
      n.update(currentTime);
  
      if (n.checkHit(currentTime, mouseX, mouseY)) {
        stats.addHit();
        sounds.playClick();
        notes.remove(i);
        continue;
      }
  
      if (n.missed) {
        stats.addMiss();
        sounds.playError();
        notes.remove(i);
        continue;
      }
  
      n.display();
    }
  }
  
  stats.display();
  
  rectMode(CENTER);
  //rect(350, 250, 100, 100);
  //rect(350, 350, 100, 100);
  //rect(350, 450, 100, 100);
  //rect(450, 250, 100, 100);
  noFill();
  stroke(255);
  rect(450, 350, 300, 300);
  //rect(450, 450, 100, 100);
  //rect(550, 250, 100, 100);
  //rect(550, 350, 100, 100);
  //rect(550, 450, 100, 100);
}


void Play() {
  playViewHelper();
}
void playReturn() {
  playViewHelper();
}

void Settings() {
  settingsViewHelper();
}
void settingsReturn() {
  settingsViewHelper();
}

void playViewHelper() {
  sideViewHelper();
  playView = !playView;
  playBar.setVisible(playView);
}
void settingsViewHelper() {
  sideViewHelper();
  settingsView = !settingsView;
  settingsBar.setVisible(settingsView);
}
void sideViewHelper() {
  sidebarView = !sidebarView;
  sidebar.setVisible(sidebarView);
}


void Cursor(int n) {
  customCursor = loadImage(cursorList[n] + ".png");
  cursor(customCursor);
}


void playSong() {
  if (selected == 0) {
    error.setText("Select a song first");
  } else {
    error.setText("");
    if (sounds != null) sounds.pause();
    sounds = new SoundManager(this, selected, speed);
  }
}
void song1() {
  selected = 1;
  playSong();
}
void song2() {
  selected = 2;
  playSong();
}

void Confirm() {
  playSong();
  error.setText("");
  
  stats.setSpeed(speed);

  String[] lines = loadStrings("song" + selected + ".csv");
  loadNoteData(lines);

  gameActive = true;
}

void loadNoteData(String[] lines) {
  notes.clear();
  stats.totalNotes = 0;
  for (String line : lines) {
    if (line.trim().length() == 0 || line.startsWith("time")) continue;
    String[] parts = split(line, ',');
    if (parts.length >= 3) {
      float time = float(trim(parts[0]));
      String pos = trim(parts[1]);
      String col = trim(parts[2]);
      notes.add(new Note(col, pos, time));
      stats.totalNotes++;
    }
  }
}
