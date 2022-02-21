// Test bench
// Program Counter (Instruction Fetch)

module ProgCtr_tb;

//timeunit 1ns/1ps;
`timescale 1ns/ 1ps

// Define signals to interface with UUT
bit Reset;
bit Start;
bit Clk;
bit BranchAbsEn;
bit BranchRelEn;
bit ALU_flag;
bit [9:0] TargetOrOffset;
logic [9:0] NextInstructionIndex;

// Instatiate and connect the Unit Under Test
ProgCtr uut (
  .Reset(Reset),
  .Start(Start),
  .Clk(Clk),
  .BranchAbsEn(BranchAbsEn),
  .BranchRelEn(BranchRelEn),
  .ALU_flag(ALU_flag),
  .Target(TargetOrOffset),
  .ProgCtr(NextInstructionIndex)
);

integer ClockCounter = 0;
always @(posedge Clk)
  ClockCounter <= ClockCounter + 1;

// The actual testbench logic
//
// In this testbench, let's look at 'manual clocking'
initial begin
  // Time 0 values
  $display("Initialize Testbench.");
  Reset = '1;
  Start = '0;
  Clk = '0;
  BranchAbsEn = '0;
  BranchRelEn = '0;
  ALU_flag = '0;
  TargetOrOffset = '0;

  // Advance to simulation time 1, latch values
  #1 Clk = '1;

  // Advance to simulation time 2, check results, prepare next values
  #1 Clk = '0;
  $display("Checking Reset behavior");
  assert (NextInstructionIndex == 'd0);
  Reset = '0;

  // Advance to simulation time 3, latch values
  #1 Clk = '1;
  // Advance to simulation time 4, check results, prepare next values
  #1 Clk = '0;
  $display("Checking that nothing happens before Start");
  assert (NextInstructionIndex == 'd0);
  Start = '1;

  // Advance to simulation time 5, latch values
  #1 Clk = '1;
  Start = '0;
  // Advance to simulation time 6, check results, prepare next values

  // Testing for start, prog 1, 2 ,3
 /* #1 Clk = '0;
  #1 Clk = '1;
  Start = '1;
  #1 Clk = '0;
  #1 Clk = '1;
  Start = '0;
  #1 Clk = '0;
  #1 Clk = '1;
  Start = '1;
  #1 Clk = '0;
  #1 Clk = '1;
  Start = '0;
  #1 Clk = '0;
  #1 Clk = '1;
  Start = '1;
  #1 Clk = '0;
  #1 Clk = '1;
  Start = '0;
  #1 Clk = '0;
  #1 Clk = '1;
  #1 Clk = '0;
  #1 Clk = '1;
  #1 Clk = '0;
  #1 Clk = '1; */

  #1 Clk = '0;
  //#1 Clk = '1;
  Start = '1;
  BranchRelEn = '1;
  ALU_flag = '1;
  TargetOrOffset = 'd10;
  
  //#1 Clk = '0;
  #1 Clk = '1;
  #1 Clk = '0;
  #1 Clk = '1;
   #1 Clk = '0;
  #1 Clk = '1;
   #1 Clk = '0;
  #1 Clk = '1;

  $display("Checking that nothing happened during Start");
  assert (NextInstructionIndex == 'd0);
 // Start = '0;

  // Advance to simulation time 7, latch values
 // #1 Clk = '1;

  // Advance to simulation time 8, check outputs, prepare next values
 // #1 Clk = '0;
  $display("Checking that first Start went to first program");
  assert (NextInstructionIndex == 'd000);
  // No change in inputs

  // Advance to simulation time 9, latch values
  //#1 Clk = '1;

  // Advance to simulation time 10, check outputs, prepare next values
 /* #1 Clk = '0;
  $display("Checking that no branch advanced by 1");
  assert (NextInstructionIndex == 'd001);
  BranchAbsEn = '1;
  TargetOrOffset = 'd10;

  // Latch, check, setup next test
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Checking that absolute branch went to target");
  assert (NextInstructionIndex == 'd10);
  BranchAbsEn = '0;
  BranchRelEn = '1;
  TargetOrOffset = 'd5;
  // note, ALU_flag still 0

  // Latch, check, setup next test
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Checking that relative branch with no ALU flag did not jump");
  assert (NextInstructionIndex == 'd11);
  BranchAbsEn = '0;
  BranchRelEn = '1;
  TargetOrOffset = 'd5;
  ALU_flag = '1;

  // Latch, check, setup next test
  #1 Clk = '1;
  #1 Clk = '0;
  $display("Checking that relative branch with ALU flag did jump");
  assert (NextInstructionIndex == 'd16);

  $display("All checks passed."); */
end

/*always begin
  #1  Clk = 'b1;
  #1  Clk = 'b0;
end */


initial begin
  $dumpfile("ProgCtr.vcd");
  $dumpvars();
  $dumplimit(104857600); // 2**20*100 = 100 MB, plenty.
end

endmodule
