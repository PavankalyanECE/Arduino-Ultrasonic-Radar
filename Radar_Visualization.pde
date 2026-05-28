import processing.serial.*;

final String PORT_NAME = "COM3";
final int BAUD_RATE = 9600;

final int ALERT_CM = 30;

Serial myPort;

String data = "";

int iAngle = 0;
int iDistance = 400;

final int TRAIL_LEN = 90;

float[] trailAngle = new float[TRAIL_LEN];
float[] trailDist  = new float[TRAIL_LEN];

int trailIdx = 0;

void setup() {

  size(1200, 700);

  smooth();
  background(0);

  for (int i = 0; i < TRAIL_LEN; i++) {

    trailAngle[i] = -1;
    trailDist[i] = 400;
  }

  try {

    myPort = new Serial(this, PORT_NAME, BAUD_RATE);
    myPort.bufferUntil('.');

  } catch (Exception e) {

    println("Serial port error: " + e.getMessage());

    println("Available ports:");
    printArray(Serial.list());
  }
}

void draw() {

  fill(0, 25);
  noStroke();
  rect(0, 0, width, height);

  drawRadarGrid();
  drawTrail();
  drawSweepLine();
  drawDetectedObjects();
  drawStatusBar();
}

void drawRadarGrid() {

  float cx = width / 2.0;
  float cy = height - height * 0.074;

  float r = width - width * 0.0625;

  pushMatrix();

  translate(cx, cy);

  noFill();

  strokeWeight(1);
  stroke(0, 100, 0);

  for (int i = 1; i <= 4; i++) {

    arc(0, 0, r * 0.25 * i, r * 0.25 * i, PI, TWO_PI);
  }

  for (int a = 0; a <= 180; a += 30) {

    line(
      0,
      0,
      -(r / 2) * cos(radians(a)),
      -(r / 2) * sin(radians(a))
    );
  }

  fill(0, 180, 0);

  textSize(12);
  textAlign(CENTER);

  text("100cm", 0, -(r * 0.25 / 2) - 5);
  text("200cm", 0, -(r * 0.50 / 2) - 5);
  text("300cm", 0, -(r * 0.75 / 2) - 5);
  text("400cm", 0, -(r * 1.00 / 2) - 5);

  textSize(13);

  float labelR = r / 2 - 25;

  text("0°",   -labelR * cos(radians(0)),   -labelR * sin(radians(0)) - 6);
  text("30°",  -labelR * cos(radians(30)),  -labelR * sin(radians(30)));
  text("60°",  -labelR * cos(radians(60)),  -labelR * sin(radians(60)));
  text("90°",  -labelR * cos(radians(90)),  -labelR * sin(radians(90)) - 8);
  text("120°", -labelR * cos(radians(120)), -labelR * sin(radians(120)));
  text("150°", -labelR * cos(radians(150)), -labelR * sin(radians(150)));
  text("180°", -labelR * cos(radians(180)), -labelR * sin(radians(180)) - 6);

  popMatrix();
}

void drawTrail() {

  float cx = width / 2.0;
  float cy = height - height * 0.074;

  float maxR = height - height * 0.12;

  pushMatrix();

  translate(cx, cy);

  for (int i = 0; i < TRAIL_LEN; i++) {

    if (trailAngle[i] < 0) continue;

    float alpha = map(i, 0, TRAIL_LEN, 20, 120);

    if (trailDist[i] <= ALERT_CM) {
      stroke(255, 30, 30, alpha);
    } else {
      stroke(30, 220, 50, alpha);
    }

    strokeWeight(5);

    float px = pixX(trailAngle[i], trailDist[i], maxR);
    float py = pixY(trailAngle[i], trailDist[i], maxR);

    point(px, py);
  }

  popMatrix();
}

void drawSweepLine() {

  float cx = width / 2.0;
  float cy = height - height * 0.074;

  float len = height - height * 0.12;

  pushMatrix();

  translate(cx, cy);

  strokeWeight(3);
  stroke(30, 255, 60, 200);

  line(
    0,
    0,
    len * cos(radians(iAngle)),
    -len * sin(radians(iAngle))
  );

  popMatrix();
}

void drawDetectedObjects() {

  if (iDistance >= 400) return;

  float cx = width / 2.0;
  float cy = height - height * 0.074;

  float maxR = height - height * 0.12;

  pushMatrix();

  translate(cx, cy);

  if (iDistance <= ALERT_CM) {

    strokeWeight(14);
    stroke(255, 0, 0, 230);

  } else {

    strokeWeight(10);
    stroke(255, 255, 0, 200);
  }

  point(
    pixX(iAngle, iDistance, maxR),
    pixY(iAngle, iDistance, maxR)
  );

  popMatrix();
}

void drawStatusBar() {

  noStroke();

  fill(0);

  rect(0, height - height * 0.065, width, height * 0.065);

  textSize(18);

  textAlign(LEFT, CENTER);

  fill(98, 245, 31);

  text(
    "Distance: " + (iDistance < 400 ? iDistance + " cm" : "---"),
    12,
    height - height * 0.032
  );

  textAlign(CENTER, CENTER);

  text(
    "Angle: " + iAngle + "°",
    width / 2.0,
    height - height * 0.032
  );

  textAlign(RIGHT, CENTER);

  if (iDistance <= ALERT_CM) {

    fill(255, 30, 30);

    text(
      "!! OBJECT DETECTED – " + iDistance + " cm !!",
      width - 12,
      height - height * 0.032
    );

  } else {

    fill(98, 245, 31);

    text(
      "SCANNING...",
      width - 12,
      height - height * 0.032
    );
  }
}

float pixX(float angleDeg, float distCm, float maxR) {

  return (distCm / 400.0) * maxR * cos(radians(angleDeg));
}

float pixY(float angleDeg, float distCm, float maxR) {

  return -(distCm / 400.0) * maxR * sin(radians(angleDeg));
}

void serialEvent(Serial port) {

  data = port.readStringUntil('.');

  if (data == null) return;

  data = trim(data);

  int comma = data.indexOf(",");

  if (comma < 1) return;

  try {

    iAngle = int(float(data.substring(0, comma)));
    iDistance = int(float(data.substring(comma + 1)));

    iAngle = constrain(iAngle, 0, 180);
    iDistance = constrain(iDistance, 0, 400);

    trailAngle[trailIdx] = iAngle;
    trailDist[trailIdx] = iDistance;

    trailIdx = (trailIdx + 1) % TRAIL_LEN;

  } catch (Exception e) {
  }
}
