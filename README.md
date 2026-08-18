# Arduino Ultrasonic Radar System 📡

A 180-degree radar system built with **Arduino, HC-SR04 ultrasonic sensor, and a servo motor**, with real-time visualization using **Processing 4**. The radar continuously sweeps from **0° to 180°** and maps detected objects on a green-grid radar interface. If an object breaches the **30 cm alert threshold**, the target turns red on the screen and a buzzer sounds.

## 📸 Project Images

### 🔧 Final Project

![Arduino Ultrasonic Radar - Final Project](./Hardware-&-Image's/Final-Project.png)

### 🤖 Project Hardware

![Arduino Ultrasonic Radar - Project Hardware](./Hardware-&-Image's/Project-IMG.jpg)

### 🎯 Object Detection

![Arduino Ultrasonic Radar - Object Detection](./Hardware-&-Image's/Radar-Detects.jpg)

### 📡 Radar View

![Arduino Ultrasonic Radar - Radar View](./Hardware-&-Image's/Radar-View.jpg)

### 💻 Simulation

![Arduino Ultrasonic Radar - Simulation](./Hardware-&-Image's/Simulation-IMG.png)

## Hardware Required

* 1x Arduino (Uno/Nano/Mega)
* 1x HC-SR04 Ultrasonic Sensor
* 1x Micro Servo (e.g., SG90)
* 1x Active/Passive Buzzer
* Jumper wires & Breadboard

## Wiring Guide

| Component        | Arduino Pin |
| :--------------- | :---------- |
| **Servo Signal** | Pin 9       |
| **HC-SR04 Trig** | Pin 10      |
| **HC-SR04 Echo** | Pin 11      |
| **Buzzer (+)**   | Pin 12      |

## Software Setup

1. **Arduino:** Open `Arduino_Radar.ino` in the Arduino IDE. Install the built-in `Servo` library if you haven't already. Upload the code to your board.

2. **Processing:** Download [Processing 4](https://processing.org/). Open `Processing_Radar.pde`.

3. **Install Serial Library:** In Processing, go to **Sketch > Import Library > Manage Libraries**, search for **Serial**, and install it.

4. **Configure Port:** In the Processing sketch, locate:

   ```java
   final String PORT_NAME = "COM3";
   ```

   Change `"COM3"` to the COM port used by your Arduino, for example `COM5`.

5. Click **Run** in Processing to launch the radar visualizer.

## Features

* **Real-time Sweep:** Visualizes the servo's physical sweep with a fading trail effect.
* **180° Detection:** Continuously scans the surrounding area from 0° to 180°.
* **Proximity Alert:** Triggers a 1 kHz tone and turns the visual target red when an object is closer than 30 cm.
* **Out-of-Range Handling:** Automatically caps readings beyond 400 cm to keep the data clean.
* **Graphical Radar Interface:** Displays detected objects and their distance in real time using Processing 4.
* **Arduino + Processing Communication:** Sends sensor angle and distance data through serial communication.

## Project Working

The **HC-SR04 ultrasonic sensor** is mounted on an **SG90 servo motor**. The servo sweeps the sensor from **0° to 180°**, while the Arduino continuously measures the distance to nearby objects.

The Arduino sends the **angle and distance data** to Processing 4 through serial communication. Processing converts this data into a graphical radar display.

When an object is detected within **30 cm**, the radar target changes to **red** and the buzzer generates an alert tone.

## System Overview

```text
        ┌──────────────────┐
        │   Arduino UNO    │
        └────────┬─────────┘
                 │
        ┌────────┴─────────┐
        │                  │
   ┌────▼─────┐      ┌─────▼─────┐
   │  SG90     │      │  HC-SR04  │
   │  Servo    │      │ Ultrasonic│
   └────┬─────┘      └─────┬─────┘
        │                  │
        └────────┬─────────┘
                 │
          Distance + Angle
                 │
        ┌────────▼─────────┐
        │   Processing 4   │
        │  Radar Display   │
        └──────────────────┘
```

## Applications

* Object detection
* Distance measurement
* Robotics
* Autonomous systems
* Security and surveillance prototypes
* Embedded systems learning
* Ultrasonic sensing experiments

## Repository Structure

```text
Arduino-Ultrasonic-Radar/
│
├── Arduino_Radar.ino
├── Processing_Radar.pde
│
└── Hardware-&-Image's/
    ├── Final-Project.png
    ├── Project-IMG.jpg
    ├── Radar-Detects.jpg
    ├── Radar-View.jpg
    └── Simulation-IMG.png
```

## Author

**Pavan Kalyan Imandi**

Electronics & Communication Engineering (ECE)

GitHub: [PavankalyanECE](https://github.com/PavankalyanECE)

---

⭐ If you found this project useful, consider giving the repository a **star**!
