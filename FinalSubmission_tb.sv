// Create Date:   2022.02.23
// Design Name:   TopLevel Test Bench for Final Submission Testing
// Module Name:   FinalSubmission_tb.v
// CSE141L WI22


// NOTE: We provide this testbench as a reference to assist you as starting point.
// You are responsible for ensuring that your final submission includes a testbench
// that clearly demonstrates your processor's ability to execute the three required
// programs.
//
// If you are unable to get the Start/Done signalling working, you should create
// three separate test benches that exercise each program individually.


module FinalSubmission_tb;

timeunit 1ns;
timeprecision 1ps;

// Storage for final data memory to compare against
logic [8-1:0] DataMemoryAtFinish[0:2**8-1];

// To DUT Inputs
bit Reset = 1'b1;
bit Start;
bit Clk;

// From DUT Outputs
wire Ack;              // done flag

// Instantiate the Device Under Test (DUT)
TopLevel DUT (
  .Reset  (Reset),
  .Start  (Start),
  .Clk    (Clk ),
  .Ack    (Ack )
);

// This is the important part of the testbench, where logic might be added
initial begin
  // Reset begins asserted.

  // Load the "golden image" data memory once at the beginning
  // Did you choose the 11-bit or 16-bit interpretation for Program 2?
  $readmemh("data_mem_01-golden-P2_11.hex", DataMemoryAtFinish);
  //$readmemh("data_mem_01-golden-P2_16.hex", DataMemoryAtFinish);

  // De-assert Reset, Assert Start to "load" P1 as-needed
  #10 Reset = 'b0;
  #10 Start = 'b1;

  // Load Data Memory for P1
  // You can do this here, or it may be easier to simply have loaded all
  // of data memory in the DataMem module during reset (this is the default
  // choice of the sample processors we gave).

  // launch program in DUT
  $display("*** P1 Start");
  #10 Start = 0;

  // Wait for done flag, then display results
  wait (Ack);

  // Test the correctness
  for(int j=30; j<60; j++) begin
    if (DUT.DM1.Core[j] == DataMemoryAtFinish[j])
      $display("    DM[%d] - Good.", j);
    else
      $display("!!! DM[%d] - WRONG. Expected 0x%02h  Got 0x%02h", j, DataMemoryAtFinish[j], DUT.DM1.Core[j]);
  end

  // Display any relevant diagnostic or performance measurments for P1
  $display("last instruction = %d", DUT.PC1.ProgCtr);



  // Assert Start to "load" P2 as-needed
  $display("*** P2 Start");
  #10 Start = 'b1;

  // Load Data Memory for P2
  // You can do this here, or it may be easier to simply have loaded all
  // of data memory in the DataMem module during reset (this is the default
  // choice of the sample processors we gave).

  // launch program in DUT
  #10 Start = 0;

  // Wait for done flag, then display results
  wait (Ack);

  // Test the correctness
  for(int j=94; j<124; j++) begin
    if (DUT.DM1.Core[j] == DataMemoryAtFinish[j])
      $display("    DM[%d] - Good.", j);
    else
      $display("!!! DM[%d] - WRONG. Expected 0x%02h  Got 0x%02h", j, DataMemoryAtFinish[j], DUT.DM1.Core[j]);
  end

  // Display any relevant diagnostic or performance measurments for P2
  $display("last instruction = %d", DUT.PC1.ProgCtr);



  // Assert Start to "load" P3 as-needed
  $display("*** P3 Start");
  #10 Start = 'b1;

  // Load Data Memory for P3
  // You can do this here, or it may be easier to simply have loaded all
  // of data memory in the DataMem module during reset (this is the default
  // choice of the sample processors we gave).

  // launch program in DUT
  #10 Start = 0;

  // Wait for done flag, then display results
  wait (Ack);

  // Test the correctness
  for(int j=192; j<195; j++) begin
    if (DUT.DM1.Core[j] == DataMemoryAtFinish[j])
      $display("    DM[%d] - Good.", j);
    else
      $display("!!! DM[%d] - WRONG. Expected 0x%02h  Got 0x%02h", j, DataMemoryAtFinish[j], DUT.DM1.Core[j]);
  end

  // Display any relevant diagnostic or performance measurments for P3
  $display("last instruction = %d", DUT.PC1.ProgCtr);



  #10 $stop;
end

// This generates the system clock
always begin   // clock period = 10 Verilog time units
  #5 Clk = 1'b1;
  #5 Clk = 1'b0;
end

endmodule

