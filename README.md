# Double Pendulum Simulation

This project is a simulation of a double pendulum system in 3D, implemented using GDScript in the Godot game engine. The primary objective is to programmatically showcase hierarchical object movement using simplified physics principles, specifically the chaotic and dynamic motion of a double pendulum under gravitational influence with damping.

## Table of Contents
- [Overview](#overview)
- [Project Structure](#project-structure)
- [Implementation Details](#implementation-details)
- [Setup and Usage](#setup-and-usage)
- [Testing and Debugging](#testing-and-debugging)
- [Contributors](#contributors)

## Overview

This project demonstrates the complex, chaotic motion of a double pendulum—a pendulum with another pendulum attached to its end. This kind of system showcases hierarchical motion and interdependency between connected parts, as the second pendulum's motion is influenced by the movement of the first. The Godot engine’s `_physics_process` function updates positions at 60 frames per second, producing smooth, realistic motion.

**Key Features:**
- **Hierarchical Motion**: Pendulum arms and masses follow a parent-child relationship, with each element’s motion impacting others.
- **Smooth Movement**: Damping is applied to simulate frictional forces, stabilizing the system over time.
- **Simplified Physics**: Uses basic physics calculations, avoiding overly complex modeling for ease of implementation and testing.

## Project Structure

The simulation’s scene tree is structured as follows:
- **Anchor (Node3D)**: Root node anchoring the double pendulum to a fixed point in space.
- **Pendulum1 (Node3D)**: Represents the first pendulum arm. Directly connected to the Anchor.
  - **Rod1 (Node3D)**: A rod that visually represents the first arm. Scaled based on `length1`.
  - **Mass1 (Node3D)**: A spherical node representing the mass at the end of the first pendulum arm.
- **RigidBody3D (Node3D)**: A rigid body simulating the second pendulum’s physics.
  - **Rod2 (Node3D)**: A rod that visually represents the second arm, scaled based on `length2`.
  - **Mass2 (Node3D)**: A sphere representing the mass at the end of the second pendulum arm.

This hierarchy enables the simulation of dependent motion, where movement in the first pendulum influences the second.

## Implementation Details

### Physical Constants
- **`G`**: Gravitational constant (9.81 m/s²) simulating Earth's gravity.
- **`DAMPING`**: Set to 0.999, representing energy dissipation over time, simulating a frictional effect on motion to prevent unrealistic perpetual motion.

### Pendulum Properties
- **`length1` and `length2`**: Define the lengths of the first and second pendulum arms, respectively.
- **`mass1` and `mass2`**: Represent the masses at the end of each pendulum arm. Although they don't affect the visual representation, these values influence the physics calculations, determining the angular velocity and acceleration.

### State Variables
- **Angular Positions (`theta1`, `theta2`)**: Represent the angles of each pendulum arm relative to the vertical axis.
- **Angular Velocities (`omega1`, `omega2`)**: Represent the rate of angular change for each pendulum arm. These values are updated every frame.
- **Angular Accelerations (`alpha1`, `alpha2`)**: Calculated each frame using simplified equations of motion.
- **Time Step (`dt`)**: Set to 0.016, representing ~60 updates per second.

### Methods

- **_ready()**: Initializes the pendulum structure and calls the `setup_pendulum()` function to establish initial positions and scales.
  
- **setup_pendulum()**: 
  - **Rod1**: Scaled to match `length1`, and positioned relative to `Anchor`.
  - **Rod2**: Scaled to match `length2`, and positioned at the end of Rod1, acting as the base for the second pendulum arm.
  - **Masses**: Positioned according to `length1` and `length2`, respectively, so they appear at the end of each rod.

- **_physics_process(delta)**:
  - **Angular Acceleration Calculation**:
    - Using equations derived from the Lagrangian mechanics model, angular accelerations (`alpha1` and `alpha2`) are calculated based on `G`, `theta1`, `theta2`, `mass1`, `mass2`, and other variables.
  - **Velocity and Position Update**:
    - Angular velocities (`omega1`, `omega2`) are updated based on the calculated angular accelerations and dampened by `DAMPING` to simulate frictional energy loss.
    - Angular positions (`theta1`, `theta2`) are incremented by the updated angular velocities.
  - **Position Calculation**:
    - Converts angular positions to Cartesian coordinates, enabling `Mass1` and `Mass2` to follow the calculated paths.

## Setup and Usage

### Steps to Run the Simulation

1. **Import the Project**: Open this project in the Godot engine. Ensure all nodes are correctly configured in the hierarchy as specified above.
2. **Run the Simulation**: Press the play button to start the simulation. The pendulums will begin to move, demonstrating realistic motion based on physical principles.
3. **Parameter Modification**:
   - **Change Physical Constants**: Adjust `G` or `DAMPING` for different gravitational forces or friction levels.
   - **Vary Pendulum Properties**: Modify `length1`, `length2`, `mass1`, and `mass2` to observe different types of motion.
![image](https://github.com/user-attachments/assets/0f5b05ab-f88c-449e-9b48-2d2f840e7482)

## Testing and Debugging

- **Git Log and Kanban Board**: All tasks were tracked with Git commits and a Kanban board to monitor project progress.
  
- **Testing Methods**:
  - **Assert Statements**: Incorporated at key points to verify calculations, ensuring angular positions stay within realistic bounds.
  - **Image Logging**: Images were captured at various frames to confirm that each step produces the expected movement patterns.
  - **Troubleshooting**: Adjusted the damping constant and mass values as needed to prevent oscillations from becoming exaggerated or unrealistically perpetual.

- **Debugging Examples**:
  - **Velocity Clamping**: Adjusted angular velocities to prevent over-acceleration during certain high-speed simulations.
  - **Error Logging**: Used print statements and Git commit messages to document and resolve issues, improving the final simulation quality.

## Contributors

- **Paramvir Singh Thind**: Imported and set up initial objects, positioned the Anchor and main nodes.
- **Shreyas Dutt**: Developed and organized the node hierarchy, ensuring proper connections and dependencies.
- **Manpreet Singh**: Implemented the `_physics_process` method, focusing on position and velocity updates for realistic movement.
- **Sahibjeet Singh**: Defined the movement logic and physical constants, created the documentation, and oversaw final adjustments.
- **Shefreen Kaur**: Fine-tuned the smoothness of motion and adjusted visual scaling of rods and masses for an accurate appearance.
- **Samardeep Singh Sidhu**: Responsible for testing and debugging, applied assert statements, and documented key troubleshooting processes.

