/*
  With this code you can make the UltraGuitar play.
  
  Author: Simon "Simonexc" Trochimiak
  28 February 2016
*/

#include <NewPing.h> // import library

#define SINGLE_CHORD_LENGTH 2  // set it to your length of single chord
#define INITIAL_TRESHOLD    2  // set it to your initial treshold

#define TRIGGER_PIN         12
#define ECHO_PIN            11
#define MAX_DISTANCE        26 // 26 cm
#define BUTTON_MAJOR        8
#define BUTTON_MINOR        9
#define BUTTON_7            10
#define HOW_MANY_CHORDS     12

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

void setup() {
  
  Serial.begin(115200);
  pinMode(BUTTON_MAJOR, INPUT_PULLUP);
  pinMode(BUTTON_MINOR, INPUT_PULLUP);
  pinMode(BUTTON_7, INPUT_PULLUP);
  
}

void loop() {
  
  delay(236);
  unsigned int uS = sonar.ping() / US_ROUNDTRIP_CM; // get distance in centimeters
  char chord = min((uS-INITIAL_TRESHOLD)/SINGLE_CHORD_LENGTH, HOW_MANY_CHORDS-1);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
  boolean stateMajor = digitalRead(BUTTON_MAJOR);
  boolean stateMinor = digitalRead(BUTTON_MINOR);
  boolean state7 = digitalRead(BUTTON_7);
  
  if (!stateMajor || !stateMinor || !state7) {  // if any of these buttons are pushed
    if (!stateMinor) {
      chord += HOW_MANY_CHORDS;
    }
    else if (!state7) {
      chord += HOW_MANY_CHORDS*2;
    }
    Serial.write('B'+chord);
  }
  else {
    Serial.print('A');
  }
  
}
