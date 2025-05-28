import processing.sound.*;

class SoundManager {
  SoundFile clickSound;
  SoundFile errorSound;
  SoundFile musicTrack;

  SoundManager(PApplet sketch) {
    clickSound = new SoundFile(sketch, "click.wav");
    errorSound = new SoundFile(sketch, "error.wav");
    musicTrack = new SoundFile(sketch, "song.wav");
    musicTrack.play();
  }

  void playClick() {
    clickSound.play();
  }

  void playError() {
    errorSound.play();
  }

  double getTime() {
    return musicTrack.position();
  }
}
