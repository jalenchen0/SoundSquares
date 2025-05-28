class StatsManager {
  int totalNotes = 0;
  int hits = 0;
  int misses = 0;
  int combo = 0;

  void addHit() {
    hits++;
    combo++;
  }

  void addMiss() {
    misses++;
    combo = 0;
  }

  void display() {
    fill(255);
    text("Hits: " + hits, 10, 20);
    text("Misses: " + misses, 10, 40);
    text("Combo: " + combo, 10, 60);
    float accuracy = totalNotes > 0 ? (hits * 100.0 / totalNotes) : 0;
    text("Accuracy: " + nf(accuracy, 0, 2) + "%", 10, 80);
  }
}
