# ✈️ Aircraft Flight Dynamics & Sensor Fusion Simulator

A comprehensive MATLAB-based simulation environment for aircraft flight dynamics, complete with a real-time Cockpit GUI, sensor modeling, and data logging. 

This project demonstrates the application of physics-based modeling, avionics instrumentation, and software engineering best practices (MVC-like architecture) to simulate various flight scenarios (Manual, Standard, Turbulence).

## 🛠️ Tech Stack & Skills
* **Language:** MATLAB
* **UI/UX:** MATLAB App Designer (`uifigure`, `uigauge`, `uiaxes`)
* **Core Concepts:** Kinematics, Sensor Modeling, Control Systems, Real-time Rendering, Event-Driven Programming.

## 📂 Project Architecture
To ensure scalability and maintainability, the project follows a modular architecture:
* `main.m`: The central controller managing state, callbacks, and the main simulation loop with robust error handling (`try-catch`).
* `src/gui/`: Handles the visual initialization (`init_cockpit_gui.m`) and real-time updates (`update_instruments.m`) of the cockpit dials.
* `src/models/`: Contains the core physics (`kinematics_update.m`) and automatic flight scenario logic (`scenario_logic.m`).
* `src/analysis/`: Generates post-flight 3D dashboards (`plot_post_flight.m`).

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