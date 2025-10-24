-- -- This repository is moved to https://github.com/bi-tud-sds/mt-tmvp --

# MT-TMVP: Modular Tiled TMVP-based Polynomial Multiplication for Post-Quantum Cryptography on FPGAs

## Overview

This repository contains the hardware design files and verification environment for the **MT-TMVP** (Modular Tiled Toeplitz Matrix-Vector Polynomial) multiplication algorithm, which is proposed and developed for efficient Post-Quantum Cryptography (PQC) on FPGA platforms. The algorithm optimizes polynomial multiplication by utilizing a modular architecture, which reduces computational complexity, and enhances hardware resource utilization. The main target is resource-constrained devices, particularly those used in lattice-based PQC schemes.

The design is implemented in Verilog and includes test benches for verification, along with constraints and memory blocks to ensure correct FPGA configuration. The verification ensures correctness by cross-checking the hardware results against MATLAB-based reference implementations.

## Directory Structure

```plaintext
├── Constraint
│   └── Top.xdc                       # Constraints file for FPGA implementation
├── HDL
│   ├── Previously_Developed
│   │   ├── dual_port_ram.v           # Dual-port RAM module
│   │   ├── MatrixVectorMultiplier.v  # Matrix-Vector Multiplier module
│   │   ├── TMVP2.v                   # TMVP2 module for polynomial multiplication
│   │   ├── TMVP2_main.v              # Main module for TMVP2
│   │   └── Top.v                     # Top-level module
│   └── Memory
│       └── ram.v                     # RAM block for memory management
├── Verification
│   ├── Final_Verification
│   ├── Main_Verification
│   ├── Multiplier_Verification
│   └── TMVPV2_Verification
├── LICENSE                           # License file
└── README.md
```

### File Descriptions:

- **Constraint/Top.xdc**: FPGA constraints file for clock configuration.
- **HDL/Previously_Developed**:
  - **dual_port_ram.v**: Verilog code for dual-port RAM, which is used to store intermediate data during the multiplication process.
  - **MatrixVectorMultiplier.v**: Verilog module that performs the matrix-vector multiplication used in polynomial multiplication.
  - **TMVP2.v**: Implementation of the TMVP-2 technique for polynomial multiplication.
  - **TMVP2_main.v**: Top-level Verilog file that integrates the TMVP-2 multiplier module.
  - **Top.v**: The top-level Verilog file that instantiates all modules and handles overall design control.
- **Memory/ram.v**: Verilog code for the memory block used for storing values during polynomial multiplication.
- **Verification**:
  - **Final_Verification**, **Main_Verification**, **Multiplier_Verification**, and **TMVPV2_Verification**: Verification folders containing files and test benches to cross-check the Verilog hardware implementation with MATLAB simulation results.
- **LICENSE**: The license governing the use of the source code.

## License

This repository is licensed under the [LICENSE] file provided. Please review the license for detailed usage rights.

## Getting Started

To get started, clone the repository:

```bash
git clone https://github.com/sec-int/mt-tmvp.git
```

Then follow the instructions for setting up the FPGA project in Vivado or your preferred FPGA development environment. 

## References

For further information on the MT-TMVP algorithm and its implementation details, refer to the paper:

**Neisarian, S., & Kavun, E. B. (2025). "MT-TMVP: Modular Tiled TMVP-based Polynomial Multiplication for Post-Quantum Cryptography on FPGAs." Cryptology ePrint Archive, Paper 2025/1018. Available at: https://eprint.iacr.org/2025/1018**

## Contact

For questions or further information, please contact:
- Shekoufeh Neisarian - [shekoufeh.neisarian@barkhauseninstitut.org](mailto:shekoufeh.neisarian@barkhauseninstitut.org)
- Elif Bilge Kavun - [elif.kavun@barkhauseninstitut.org](mailto:elif.kavun@barkhauseninstitut.org)
