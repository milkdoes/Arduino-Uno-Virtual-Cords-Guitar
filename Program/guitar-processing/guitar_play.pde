/*
  With this code your UltraGuitar will play chords!
  
  Author: Simon "Simonexc" Trochimiak
  28 February 2016
*/

import processing.serial.*; // import library serial
import ddf.minim.*;         // import library minim

Serial myPort;
Minim minim;
AudioPlayer[] player = new AudioPlayer[36];

String portName = "COM5"; // Windows: set this to the port name to which the Arduino is connected
// String portName = "/dev/ttyACM0"; // Linux
int chord = 'A';
int lastChord = 'B';
String[] chords_list = {"C.mp3",
                        "C#.mp3",
                        "D.mp3",
                        "D#.mp3",
                        "E.mp3",
                        "F.mp3",
                        "F#.mp3",
                        "G.mp3",
                        "G#.mp3",
                        "A.mp3",
                        "A#.mp3",
                        "B.mp3",
                        "Cm.mp3",
                        "C#m.mp3",
                        "Dm.mp3",
                        "D#m.mp3",
                        "Em.mp3",
                        "Fm.mp3",
                        "F#m.mp3",
                        "Gm.mp3",
                        "G#m.mp3",
                        "Am.mp3",
                        "A#m.mp3",
                        "Bm.mp3",
                        "C7.mp3",
                        "C#7.mp3",
                        "D7.mp3",
                        "D#7.mp3",
                        "E7.mp3",
                        "F7.mp3",
                        "F#7.mp3",
                        "G7.mp3",
                        "G#7.mp3",
                        "A7.mp3",
                        "A#7.mp3",
                        "B7.mp3"};

void setup() 
{
  size(200, 200);
  frameRate(100);
  myPort = new Serial(this, portName, 115200);
  minim = new Minim(this);
  for (int i = 0; i<chords_list.length; i++) {
    player[i] = minim.loadFile(chords_list[i]);
  }
}

void draw()

{
  if ( myPort.available() > 0) { //<>//
    chord = myPort.read();

    if (chord == 'A') {
      println("stop");
      
      if (player[lastChord-'B'].isPlaying()) {
        player[lastChord-'B'].pause();
      }
      
    }
    else {
      if (lastChord == chord) {
        
        if (!player[lastChord-'B'].isPlaying()) {
          println(chords_list[lastChord-'B']);
          player[lastChord-'B'].loop();
        }
        
      }
      else {
        println(chords_list[chord-'B']);
        
        if (player[lastChord-'B'].isPlaying()) {
          player[lastChord-'B'].pause();
        }
        
        lastChord = chord;
        player[lastChord-'B'].loop();
      }
    }
  }
}