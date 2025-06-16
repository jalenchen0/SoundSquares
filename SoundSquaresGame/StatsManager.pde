class StatsManager {
  int totalNotes = 0;
  int hits = 0;
  int misses = 0;
  int combo = 0;
  int maxCombo = 0;
  int score = 0;
  
  float speedMultiplier = 1.0;
  
  void setSpeed(float s) {
    speedMultiplier = s;
  }

  void addHit() {
    hits++;
    combo++;
    if (combo > maxCombo) maxCombo = combo;
    score += int(100 * combo * speedMultiplier);
  }

  void addMiss() {
    misses++;
    combo = 0;
  }

  void display() {
    fill(255);
    text("Hits: " + hits, 180, 300);
    text("Misses: " + misses, 180, 320);
    text("Combo: " + combo, 180, 340);
    text("Max Combo: " + maxCombo, 180, 360);
    float accuracy = totalNotes > 0 ? (hits * 100.0 / totalNotes) : 0;
    text("Accuracy: " + nf(accuracy, 0, 2) + "%", 180, 380);
    text("Score: " + score, 180, 400);
  }
}
