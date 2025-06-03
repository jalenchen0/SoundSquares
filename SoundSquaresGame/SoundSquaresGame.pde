import controlP5.*;
ControlP5 cp5;
Group sidebar;
boolean sidebarView = true;
Group playBar;
boolean playView = false;
Group settingsBar;
boolean settingsView = false;

PFont font;

float speed = 1;
int selected = 0;
PImage cursor;
String[] cursorList = {"White", "Blue"};

StatsManager stats;
SoundManager sounds;

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
    .setPosition((width) / 2, 50)
    .setColorValue(0xFF03FEB7)
    .setFont(createFont("Arial", 30))
  ;
  cp5.addTextlabel("label2")
    .setText("Squares")
    .setPosition((width) / 2, 100)
    .setColorValue(0xFFFF63FF)
    .setFont(createFont("Arial", 30))
  ;
  
  
  PImage example = loadImage("example.jpg");
  image(example, 100, 100);
}


void draw() {
  background(0);
  stats.display();
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
  cursor = loadImage(cursorList[n] + ".png");
  cursor(cursor);
}


void playSong() {
  if (sounds == null) {
    // display error saying "Select a song first"
  } else {
    sounds.pause();
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
  // display notes
}
