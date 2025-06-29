<div align="center">
  <img src="https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/images/diagram.png" alt="Project Diagram"/>
  <h1>This is an educational project to get familiar with the VHDL programming language</h1>
</div>

---

# Overview

This VHDL program implements a 7-segment digital clock on an FPGA. The clock displays:

- Two digits for hours
- Two for minutes
- Two for seconds
- Three for milliseconds

Once the clock reaches `23:59:59:999`, it loops back to `00:00:00:000`, as expected from a standard digital clock.

This implementation is hardware-agnostic — it contains no pin configurations, making it compatible with any FPGA board. To run this on real hardware (not just in simulation), you must manually configure the I/O ports for your specific board.

---

# Source Code

The project is modular — each file handles a distinct functionality:

- [`clock_divider.vhd`](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/src/clock_divider.vhd): Divides the native 50 MHz FPGA clock down to 1 Hz.
- [`counter_0_23.vhd`](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/src/counter_0_23.vhd): Modulo-24 counter (hours).
- [`counter_0_59.vhd`](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/src/counter_0_59.vhd): Modulo-60 counter (minutes, seconds).
- [`counter_0_999.vhd`](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/src/counter_0_999.vhd): Modulo-1000 counter (milliseconds).
- [`seg7_clock.sdc`](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/src/seg7_clock.sdc): Defines FPGA clock constraints (50 MHz) for simulation.
- [`seg7_clock.vhd`](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/src/seg7_clock.vhd): Top-level module, connects all components into a working system.
- [`seg7_decoder.vhd`](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/src/seg7_decoder.vhd): Converts binary digits into 7-segment display codes.
- [`seg_array_t.vhd`](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/src/seg_array_t.vhd): Custom data type for storing values for each 7-segment display.
- [`tb_seg7_clock.vhd`](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/src/tb_seg7_clock.vhd): Testbench for simulating the top-level clock module.

---

# Simulation

This project is free of any board-specific code, so it can be simulated on any VHDL-compatible simulator. Below are example simulation results using the Quartus simulator.

Each plot shows (top to bottom):

- 8-bit output of the least significant millisecond display
- 8-bit output of the middle millisecond display
- 8-bit output of the most significant millisecond display
- 8-bit output of the least significant second display

---

### 0 to 5 ms

![0 to 5 ms plot](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/images/0-5ms.png)

Demonstrates accurate millisecond measurement.

---

### 9 to 14 ms

![9 to 14 ms plot](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/images/9-14ms.png)

Shows carry propagation into the middle millisecond display.

---

### 99 to 104 ms

![99 to 104 ms plot](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/images/99-104ms.png)

Illustrates carry propagation into the most significant millisecond display.

---

### 999 to 1007 ms

![999 to 1007 ms plot](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/images/999-1007ms.png)

After 1000 ms, milliseconds reset and the seconds counter increments — correct carry behavior.

---

### Reset Signal

![Reset signal](https://github.com/PogSmok/7seg_clock_FPGA_VHDL/blob/main/images/reset.png)

The reset signal is asynchronous. As soon as it's asserted, the clock resets immediately — not delayed to the next clock edge.

---
