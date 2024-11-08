# 🖥️ Assembly - Computer Architecture Project

## Overview

This project is a **zero-player game** developed in **Assembly x86**, designed to simulate the evolution of a cell based on specific conditions. The program directly interacts with the CPU, demonstrating a fundamental understanding of low-level programming and computer architecture. 

The project showcases an advanced application of Assembly programming to create a simulation that operates autonomously without user input, illustrating concepts like memory management, CPU register manipulation, and conditional execution at the machine level.

## 🚀 Features

- **Zero-Player Simulation**: The program runs autonomously without any player intervention.
- **Cell Evolution Mechanics**: Implements cell evolution logic based on specific rules, simulating life cycles and conditions.
- **CPU-Level Execution**: Runs directly on the CPU using Assembly language, making the program efficient and demonstrating precise control over hardware.
- **Memory and Register Manipulation**: Uses CPU registers and direct memory manipulation to handle the simulation data.

## 📂 Project Structure

The project consists of a single Assembly file and is organized to highlight key areas of cell simulation:

- **Initialization Section**: Sets up initial conditions and prepares the memory and registers.
- **Evolution Logic**: Contains the core logic that dictates how the cell evolves over time, based on predefined rules.
- **Termination Condition**: Defines conditions under which the simulation ends, based on cell state and evolution outcomes.

## 💻 Technologies Used

- **Assembly x86**: For direct interaction with the CPU, using low-level instructions and registers.
- **CPU Registers**: Utilizes x86 registers for data manipulation and logic execution.
- **NASM (Netwide Assembler)**: An assembler for x86 code to compile the Assembly code into machine language.
- **Emulator (e.g., DOSBox)**: To test and run the program on modern systems if running directly on hardware is not feasible.

## ⚙️ Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/denisamihaila/Assembly-Arhitectura-Sistemelor-De-Calcul.git
   ```
2. Install **NASM** to assemble the code. You can download it from [NASM's official website](https://www.nasm.us/).
3. Assemble the code using NASM:
   ```bash
   nasm -f bin -o cell_simulation.bin cell_simulation.asm
   ```
4. Run the binary on an x86-compatible emulator (e.g., DOSBox) or on native x86 hardware.

## 📝 Usage

To observe the cell simulation:

1. Run the assembled binary file in an emulator or directly on compatible x86 hardware.
2. Observe the output as the program autonomously simulates the evolution of the cell based on predefined conditions.

## ✨ Code Highlights

This project highlights several key aspects of Assembly programming and computer architecture:

1. **Direct CPU Interaction**: Shows how to work directly with CPU registers and memory addresses.
2. **Efficient Memory Management**: Uses Assembly to manage memory with precision, minimizing overhead and optimizing performance.
3. **Autonomous Simulation Logic**: Implements a zero-player setup where the game evolves without any input, relying entirely on internal logic.
4. **Conditional Execution**: Demonstrates control structures and conditional jumps to dictate the evolution of the cell.

## 🔧 Future Improvements

Potential improvements for expanding functionality and usability:

- **Expanded Simulation Rules**: Introduce more complex rules to simulate additional life-like behaviors.
- **Visualization**: Create a visual output, possibly by connecting the program to a graphical interface or developing it on a platform that supports graphical rendering.
- **Port to 64-Bit Architecture**: Adapt the code for x86-64 architecture to run on modern systems without emulation.

