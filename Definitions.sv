// Package Name:   Definitions
// Project Name:   CSE141L
// Created:        2020.5.27
// Revised:        2022.1.13
//
// This file defines the parameters used in the ALU.
// `import` the package into each module that needs it.
// Packages are very useful for declaring global variables.

package Definitions;
    // There are many ways to define constants in [System]Verilog.
    // You may come across others in examples, and some forms are
    // simpler / more appropriate for different contexts.

    /*
    // Original Verilog synatx
    //   `define in Verilog works like #define in C/C++, it is
    //   a naive string replace
    //
    //   Note the lack of `;`
    //   `defines are not expressions, they are compiler directives
    `define ADD 3'b000
    `define LSH 3'b001
    `define RSH 3'b010
    `define XOR 3'b011
    `define AND 3'b100
    `define SUB 3'b101
    `define CLR 3'b110
    */

    // One SystemVerilog option: constant wires
    //
    // Recall `logic` also creates "physical wires", but unlike
    // the `wire` keyword, `logic` wires are not allowed to be
    // `x` or `z`.
    /*
    const logic [2:0]kADD  = 3'b000;
    const logic [2:0]kLSH  = 3'b001;
    const logic [2:0]kRSH  = 3'b010;
    const logic [2:0]kXOR  = 3'b011;
    const logic [2:0]kAND  = 3'b100;
    const logic [2:0]kSUB  = 3'b101;
    const logic [2:0]kCLR  = 3'b110;
    */
    const logic [3:0]kADD  = 4'b0000;
    const logic [3:0]kXOR  = 4'b0001;
    const logic [3:0]kORR  = 4'b0010;
    const logic [3:0]kLOD  = 4'b0011;
    const logic [3:0]kSTR  = 4'b0100;
    const logic [3:0]kBNE  = 4'b0101;
    const logic [3:0]kSLL  = 4'b0110;
    const logic [3:0]kSRL  = 4'b0111;
    const logic [3:0]kAND  = 4'b1000;
    const logic [3:0]kXXR  = 4'b1001;
    const logic [3:0]kCPP  = 4'b1010;
    const logic [3:0]kCYY  = 4'b1011;
    const logic [3:0]kSUB  = 4'b1100;
    const logic [3:0]kBEQ  = 4'b1101;
    const logic kRTYPE     = 1'b0;
    const logic kITYPE     = 1'b1;
    //const logic [3:0]kLDI  = 1'b1;
    //const logic [3:0]kADD  = 4'b0000;
    //const logic [3:0]kADD  = 4'b0000;
    

   // Modern SystemVerilog lets you define types. The advantage
   // of doing this is that tools can preserve type metadata,
   // e.g. enum names will appear in timing diagrams
   typedef enum logic [3:0] {
       ADD, XOR, ORR, LOD, STR, BNE, SLL, SRL,
       AND, XXR, CPP, CYY, SUB, BEQ } op_mne;
endpackage // Definitions
