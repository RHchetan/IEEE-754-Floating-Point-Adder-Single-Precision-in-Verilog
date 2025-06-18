# IEEE-754 Single Precision Floating Point Adder (Verilog)

## 📌 Description
This project implements a 32-bit IEEE-754 Single Precision Floating Point Adder using Verilog. It handles sign, exponent alignment, mantissa addition, normalization, and result packing.

---

## 📦 Files

| File             | Description                          |
|:----------------|:-------------------------------------|
| `ieee754add.v`   | IEEE-754 Floating Point Adder module  |
| `tb_ieee754add.v`| Testbench to verify the adder         |
| `README.md`      | Project documentation                 |

---

## 📐 Format: IEEE-754 Single Precision

| Bit(s) | Field     | Description                    |
|:--------|:------------|:--------------------------------|
| 31       | Sign       | 0 = positive, 1 = negative       |
| 30–23    | Exponent   | 8-bit exponent (bias 127)        |
| 22–0     | Mantissa   | 23-bit significand (with hidden 1)|

---

## 🚀 Simulation Instructions

1. Install a Verilog simulator (Icarus Verilog / ModelSim / Vivado)
2. Compile and run:
```bash
iverilog -o sim ieee754add.v tb_ieee754add.v
vvp sim
