#include <Servo.h>

// ── Pin definitions ──────────────────────────────────────────
const int SERVO_PIN      = 9;
const int TRIG_PIN       = 10;
const int ECHO_PIN       = 11;
const int BUZZER_PIN     = 12;

const int ALERT_DISTANCE = 30;   // cm – buzzer triggers at or below this

Servo radarServo;

// ── Setup ────────────────────────────────────────────────────
void setup() {
  Serial.begin(9600);
  radarServo.attach(SERVO_PIN);

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(BUZZER_PIN, OUTPUT);
}

// ── Measure distance via HC-SR04 ─────────────────────────────
long measureDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);

  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);

  digitalWrite(TRIG_PIN, LOW);

  long duration = pulseIn(ECHO_PIN, HIGH, 30000);

  long distance = duration * 0.034 / 2;

  if (distance == 0 || distance > 400) {
    distance = 400;
  }

  return distance;
}

// ── Send data + handle buzzer ─────────────────────────────────
void sendAndAlert(int angle, long dist) {

  Serial.print(angle);
  Serial.print(",");
  Serial.print(dist);
  Serial.print(".");

  if (dist <= ALERT_DISTANCE) {
    tone(BUZZER_PIN, 1000, 100);
  } else {
    noTone(BUZZER_PIN);
  }
}

// ── Main loop – continuous 0 → 180 → 0 sweep ─────────────────
void loop() {

  for (int angle = 0; angle <= 180; angle += 2) {

    radarServo.write(angle);
    delay(20);

    sendAndAlert(angle, measureDistance());
  }

  for (int angle = 180; angle >= 0; angle -= 2) {

    radarServo.write(angle);
    delay(20);

    sendAndAlert(angle, measureDistance());
  }
}
