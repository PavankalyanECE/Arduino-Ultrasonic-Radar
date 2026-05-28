# Arduino Ultrasonic Radar System 📡

A 180-degree radar system built with Arduino and visualized using Processing 4. The radar continuously sweeps from 0° to 180° and maps detected objects on a green-grid radar interface. If an object breaches the 30 cm alert threshold, the target turns red on the screen and a buzzer sounds.

## Hardware Required
* 1x Arduino (Uno/Nano/Mega)
* 1x HC-SR04 Ultrasonic Sensor
* 1x Micro Servo (e.g., SG90)
* 1x Active/Passive Buzzer
* Jumper wires & Breadboard

## Wiring Guide
| Component | Arduino Pin |
| :--- | :--- |
| **Servo Signal** | Pin 9 |
| **HC-SR04 Trig** | Pin 10 |
| **HC-SR04 Echo** | Pin 11 |
| **Buzzer (+)** | Pin 12 |

## Software Setup
1. **Arduino:** Open `Arduino_Radar.ino` in the Arduino IDE. Install the built-in `Servo` library if you haven't already. Upload the code to your board.
2. **Processing:** Download [Processing 4](https://processing.org/). Open `Processing_Radar.pde`. 
3. **Install Serial Library:** In Processing, go to *Sketch > Import Library > Manage Libraries*, search for "Serial" and install it.
4. **Configure Port:** In the Processing sketch, locate `final String PORT_NAME = "COM3";` and change `"COM3"` to whatever port your Arduino is using (e.g., `/dev/ttyUSB0` for Linux or `/dev/tty.usbmodem...` for Mac).
5. Hit **Run** in Processing to launch the visualizer!

## Features
* **Real-time Sweep:** Visualizes the servo's physical sweep with a fading trail effect.
* **Proximity Alert:** Triggers a 1kHz tone and turns the visual blip red when objects are closer than 30 cm.
* **Out-of-Range Handling:** Automatically caps readings beyond 400 cm to keep the data clean.
