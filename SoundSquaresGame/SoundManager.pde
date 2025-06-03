import processing.sound.*;

class SoundManager {
  SoundFile clickSound;
  SoundFile errorSound;
  SoundFile musicTrack;

  SoundManager(PApplet sketch, int n, float speed) {
    clickSound = new SoundFile(sketch, "click.wav");
    errorSound = new SoundFile(sketch, "error.wav");
    musicTrack = new SoundFile(sketch, "song" + n + ".wav");
    musicTrack.rate(speed);
    musicTrack.play();
  }

  void playClick() {
    clickSound.play();
  }

  void playError() {
    errorSound.play();
  }
  
  void pause() {
    musicTrack.pause();
  }

  float getTime() {
    return musicTrack.position();
  }
}
