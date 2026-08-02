# FPGA MAC Efficiency: Non-Linear LUT-DSP Resource Mapping Under Precision Scaling

> An FPGA-based hardware exploration investigating how arithmetic precision influences LUT, DSP, and Flip-Flop utilization under identical synthesis conditions.

## Overview

Modern AI accelerators frequently leverage reduced-precision arithmetic (INT4, INT8, INT16) to improve computational efficiency and reduce hardware cost. While it is commonly assumed that lowering arithmetic precision always decreases FPGA resource utilization, the underlying synthesis behavior is often far more complex.

This project investigates how arithmetic precision affects FPGA resource mapping by implementing and benchmarking multiple Multiply-Accumulate (MAC) architectures on a Xilinx Artix-7 FPGA using an identical Vivado synthesis flow.

The study reveals a **non-linear transition between LUT-based and DSP-based implementations**, demonstrating that reducing precision does not necessarily minimize hardware utilization.

---

## Objectives

- Design MAC architectures with different arithmetic precisions.
- Compare fixed-precision and runtime-adaptive implementations.
- Benchmark LUT, DSP, and Flip-Flop utilization.
- Analyze Vivado's resource inference strategy.
- Study architectural trade-offs relevant to FPGA-based AI accelerators.

---

## Features

- Fixed Precision 4-bit MAC
- Fixed Precision 8-bit MAC
- Fixed Precision 16-bit MAC
- Runtime Adaptive Precision MAC
- Modular SystemVerilog RTL Design
- Identical Vivado synthesis flow for fair comparison
- Resource utilization analysis
- DSP inference study

---

## Architecture

```text
                    +----------------------+
                    |   Input Operands     |
                    +----------+-----------+
                               |
                               |
                     +---------v----------+
                     | Precision Selector |
                     +---------+----------+
                               |
               +---------------+---------------+
               |                               |
      Fixed Precision                 Adaptive Precision
       Implementations                  Architecture
               |                               |
               +---------------+---------------+
                               |
                      +--------v--------+
                      |   Multiplier    |
                      +--------+--------+
                               |
                      +--------v--------+
                      |  Accumulator    |
                      +--------+--------+
                               |
                           MAC Output
```

---

## Repository Structure

```text
FPGA-MAC-Efficiency/
│
├── rtl/
│   ├── top_mac.sv
│   ├── multiplier.sv
│   ├── accumulator.sv
│   ├── bit_selector.sv
│   ├── sign_extender.sv
│   └── ...
│
├── tb/
│   ├── testbench.sv
│   └── ...
│
├── constraints/
│   └── *.xdc
│
├── reports/
│   ├── utilization.pdf
│   ├── timing.pdf
│   └── power.pdf
│
├── images/
│   ├── architecture.png
│   ├── utilization.png
│   └── ...
│
├── README.md
└── LICENSE
```

---

## Experimental Setup

| Parameter | Specification |
|------------|---------------|
| FPGA | Xilinx Artix-7 |
| HDL | SystemVerilog |
| EDA Tool | Xilinx Vivado |
| Precision Modes | INT4, INT8, INT16 |
| Comparison | Fixed vs Adaptive MAC |
| Evaluation Metrics | LUTs, DSPs, FFs, Timing |

---

## Results

### Resource Mapping Behavior

The synthesized implementations exhibit a distinct transition in hardware mapping as arithmetic precision increases.

| Design | LUT Usage | DSP Usage | Observation |
|---------|-----------|-----------|-------------|
| 4-bit MAC | High | 0 | Fully LUT-based implementation |
| 8-bit MAC | Highest | 0 | Peak LUT utilization |
| 16-bit MAC | Low | DSP inferred | Vivado shifts multiplication into DSP slices |
| Adaptive MAC | Additional LUTs & FFs | DSP inferred | Runtime flexibility introduces control overhead |

---

## Key Findings

### 1. Non-Linear LUT-DSP Threshold

Contrary to common intuition, reducing arithmetic precision does **not** always decrease FPGA resource utilization.

The synthesized results reveal a threshold where Vivado transitions from LUT-based arithmetic to dedicated DSP blocks.

As a result:

- 8-bit implementations consumed the highest LUT resources.
- 16-bit implementations significantly reduced LUT usage through DSP inference.

---

### 2. Runtime Adaptability Introduces Overhead

The adaptive precision MAC requires additional hardware for:

- Precision selection
- Operand routing
- Sign extension
- Control logic

Although it provides flexibility, this increases LUT and Flip-Flop utilization compared to a fixed 16-bit implementation.

---

### 3. FPGA Optimization Depends on Synthesis Decisions

FPGA resource utilization is influenced not only by operand width but also by the synthesis tool's optimization heuristics.

Vivado dynamically determines whether arithmetic operations are implemented using:

- LUT fabric
- DSP slices
- Hybrid architectures

---

## Skills Demonstrated

- FPGA Design
- RTL Development
- SystemVerilog
- Xilinx Vivado
- AI Hardware Architecture
- Resource Utilization Analysis
- DSP Inference
- Hardware Benchmarking
- Digital Design
- Computer Architecture

---

## Future Improvements

Possible extensions include:

- Pipeline optimization
- SIMD MAC implementation
- DSP48 primitive optimization
- Signed/Unsigned configurable datapath
- AXI-Stream interface
- Timing optimization
- Power analysis
- Comparison across multiple FPGA families

---

## Learning Outcomes

This project provided valuable insights into FPGA synthesis and hardware optimization.

Key takeaways include:

- Lower arithmetic precision does not always reduce hardware cost.
- DSP inference significantly affects FPGA resource utilization.
- Runtime adaptability introduces measurable architectural overhead.
- FPGA optimization decisions must be experimentally evaluated rather than assumed.

---

## Tools & Technologies

- **SystemVerilog**
- **Xilinx Vivado**
- **Artix-7 FPGA**
- **RTL Design**
- **Digital Logic Design**

---

## Acknowledgements

This project was completed as part of an independent exploration into FPGA implementation strategies for AI-oriented arithmetic architectures. The primary objective was to understand how synthesis tools optimize arithmetic hardware across different precision levels and to analyze the resulting architectural trade-offs.

---

## License

This project is open source. Feel free to use, modify, and distribute it. If you find it helpful, consider giving the repo a ⭐.
