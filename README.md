# FPGA Spartan-7 Pressure Controller

This project implements a digital pressure controller using SystemVerilog. The system was simulated and designed to run on a Xilinx Spartan-7 FPGA development board. The core logic relies on a Finite State Machine (FSM) that takes asynchronous data, synchronizes it, calculates the pressure value, and validates the system's state.

## System Architecture

The system consists of several interconnected blocks at the `top` module level:

- **Synchronizers (syncro.sv):** Prevent metastability by passing asynchronous inputs through a 2-stage flip-flop.
- **Rising Edge Detectors (re_det.sv):** Generate a single clock cycle pulse upon detecting a 0-to-1 transition of the signals.
- **Counter Interface (counter_interface.sv):** Counts the incoming data pulses (`data_i`) to simulate or read the pressure value.
- **Pressure Controller (pressure_controller.sv):** The main FSM that manages system behavior, navigating through validation, testing, and fault states.

![schema1](https://github.com/user-attachments/assets/22df2c27-5569-4f18-9d3f-ca1ae14c9318)


## Finite State Machine (FSM)

The central controller operates using 7 distinct states:
1. **IDLE (s0):** The resting state of the system.
2. **WAIT (s1):** Waits for the start signal.
3. **CAPTURE_PRESSURE (s2):** Captures the pressure value and waits for 7 clock cycles for circuit stabilization.
4. **STABLE (s3):** Marks the system as stable (turns on the corresponding LED).
5. **TESTMODE (s4):** Forced testing or diagnostic mode.
6. **PRESSURE_LIN (s5):** Checks if the read pressure matches a saved state; sends the system into FAULT if the data is corrupted.
7. **FAULT (s6):** Error state; requires an asynchronous reset to restart.

8. 
![schema2](https://github.com/user-attachments/assets/3fe434a1-db1a-433e-a4cf-43cc499eadf2)



![schema3](https://github.com/user-attachments/assets/613a2559-ea4f-46c2-abe9-776661cd5b8a)


## I/O Mapping (Xilinx Spartan-7 Board)

The project uses a constraints file (`placa.xdc`) to map the logical ports to the physical pins of the FPGA:

| I/O Port | Direction | FPGA Pin | Description |
| :--- | :--- | :--- | :--- |
| `clk_i` | Input | F14 | Clock signal |
| `rst_n_i`| Input | K1 | Asynchronous Reset (Active Low) (SW 1) |
| `data_i` | Input | V2 | Data input signal (SW) |
| `ready_i`| Input | U2 | Data ready/done signal (SW 3) |
| `test_i` | Input | U1 | Test mode activation (SW 0) |
| `led_0_o`| Output | E3 | Flag `captured_o` |
| `led_1_o`| Output | E5 | Flag `stable_flag_o` |
| `led_2_o`| Output | E6 | Flag `test_flag_o` |

## Simulation and Testing

The project includes a complete testbench (`test.sv`) that validates the top-level functionality. To run it:
1. Create a new project in Xilinx Vivado.
2. Add all `.sv` files from the `sources_1` folder.
3. Add `placa.xdc` in the *Constraints* section.
4. Add `test.sv` as a *Simulation Source*.
5. Run "Run Behavioral Simulation" to view the waveforms and state transitions.
