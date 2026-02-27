# ✈️ Avionics Instruments & 3D Flight Simulator

A comprehensive MATLAB-based simulation environment for aircraft flight dynamics, complete with a real-time Cockpit GUI, sensor modeling, and data logging. 

This project demonstrates the application of physics-based modeling, avionics instrumentation, and software engineering best practices to simulate various flight scenarios (Manual, Standard, Turbulence).

## 📊 Data Logging & Post-Flight Analysis

![Post-Flight Analysis](Post-FlighAnalysis.png)
*3D Post-simulation analysis for the "Standard" scenario: graphs of altitude, pitch, rate of climb, heading, and speed as a function of X and Y.*

During the simulation, flight parameters are continuously monitored and recorded in a `flightLog.csv` file. This allows for extensive post-flight graphical analysis. The logged data includes:

| Column | Description |
| :--- | :--- |
| **Time** | Elapsed time from the start of the simulation (in seconds). |
| **Altitude** | Aircraft altitude (in meters or arbitrary units). |
| **Speed** | Instantaneous speed (m/s or defined scenario units). |
| **ROC** | Rate of Climb / Descent (positive = ascending). |
| **Pitch** | Longitudinal inclination (nose up/down) expressed in radians. |
| **Heading** | Compass direction, in degrees or radians. |
| **X** | Horizontal X coordinate (longitudinal movement). |
| **Y** | Horizontal Y coordinate (lateral displacement). |

## 🛠️ Tech Stack & Skills
* **Language:** MATLAB
* **UI/UX:** MATLAB App Designer (`uifigure`, `uigauge`, `uiaxes`)
* **Core Concepts:** Kinematics, Sensor Modeling, Control Systems, Real-time Rendering, Event-Driven Programming.

## 📂 Project Architecture
To ensure scalability and maintainability, the project follows a clean and structured procedural architecture within a single modular script:
* `main.m`: The central controller managing state, callbacks, and the main simulation loop.
* **GUI Initialization**: Handles the visual setup (`uifigure`, `uigauge`) of the cockpit dials.
* **Physics Models**: Contains the core kinematics and automatic flight scenario logic (nested functions).
* **Data Analysis**: Generates post-flight 3D dashboards and handles `flightLog.csv` exports.

## 🚀 Features
1. **Real-Time Cockpit GUI:** Features live gauges for Altitude, Speed, Vertical Speed (Vario), Heading, and Pitch.
2. **Dynamic Flight Scenarios:**
   * **Manual Mode:** Pilot the aircraft using keyboard inputs (Pitch, Yaw, Throttle).
   * **Standard Mode:** Autonomous execution of a predefined flight envelope (Takeoff, Cruise, Descent).
   * **Turbulence Mode:** Simulates flight under adverse weather conditions using randomized noise and sinusoidal disturbances.
3. **3D Live Trajectory Tracking:** Real-time rendering of the aircraft's path in a 3D space.
4. **Data Logging & Analysis:** Automatically logs flight telemetry to `flightLog.csv` and generates a comprehensive 3D dashboard post-flight for detailed analysis.

## 🏁 How to Run
1. Open MATLAB and navigate to the project root directory.
2. Run `main.m` from the Command Window.
3. Select your desired scenario from the dropdown.
4. Click **Avvia** (Start) to begin the simulation.
5. In *Manuale* mode, use the following keys:
   * `Up Arrow` / `Down Arrow`: Adjust Pitch
   * `Left Arrow` / `Right Arrow`: Adjust Yaw
   * `+` or `M`: Increase Throttle
   * `-` or `N`: Decrease Throttle

