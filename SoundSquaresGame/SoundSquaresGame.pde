StatsManager stats;
SoundManager sounds;

void setup() {
  size(800, 600);
  stats = new StatsManager();
  sounds = new SoundManager(this);
}

void draw() {
  background(0);
  stats.display();
}
