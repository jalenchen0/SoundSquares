class Note {
  color c;
  PVector startPos, targetPos, currentPos;
  float size;
  float spawnTime;
  float travelTime = 0.6;
  float startTime;
  float maxSize = 60;
  float minSize = 10;
  float hitWindow = 0.2;

  boolean hit = false;
  boolean missed = false;
  boolean arrived = false;

  Note(String colorStr, String posStr, float time) {
    c = unhex(colorStr.substring(2));
    spawnTime = time;
    targetPos = mapPosition(posStr);
    startPos = new PVector(450, 350);
    currentPos = startPos.copy();
    startTime = spawnTime - travelTime;
  }

  void update(float currentTime) {
    if (hit || missed) return;

    if (currentTime < startTime) return;

    float progress = constrain((currentTime - startTime) / travelTime, 0, 1);
    currentPos = PVector.lerp(startPos, targetPos, progress);
    size = lerp(minSize, maxSize, progress);

    arrived = (progress >= 1.0);

    if (arrived && (currentTime - spawnTime) > hitWindow) {
      missed = true;
    }
  }

  void display() {
    if (hit || missed || millis()/1000.0 < startTime) return;

    stroke(c);
    noFill();
    rectMode(CENTER);
    rect(currentPos.x, currentPos.y, size, size);
  }

  boolean checkHit(float currentTime, float mx, float my) {
    if (!arrived || hit || missed) return false;

    float d = dist(mx, my, targetPos.x, targetPos.y);
    if (d < size/2 && abs(currentTime - spawnTime) <= hitWindow) {
      hit = true;
      return true;
    }
    return false;
  }
  
  PVector mapPosition(String pos) {
    switch(pos) {
      case "Q": return new PVector(350, 250);
      case "W": return new PVector(350, 350);
      case "E": return new PVector(350, 450);
      case "A": return new PVector(450, 250);
      case "S": return new PVector(450, 350);
      case "D": return new PVector(450, 450);
      case "Z": return new PVector(550, 250);
      case "X": return new PVector(550, 350);
      case "C": return new PVector(550, 450);
      default:  return new PVector(0,0);
    }
  }
}
