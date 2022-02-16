// CSE141L

// This is NOT synthesizable; use for logic simulation only
// Verilog Test Fixture created for module: TopLevel

// This defines what `#1` means, so later, when the clock is
// up wait `#1` then down wait `#1` we make a 1 GHz clock.
timeunit 1ns;
// This defines the precision of delays in the simulation.
// Convention is for this to be three orders of magnitude
// more precise unless you have a reason for it to be
// something else.
timeprecision 1ps;


module ClockDivider_tb;

// To DUT Inputs
bit Enable;
bit Clk;

// From DUT Outputs
bit ClkOut;

// Instantiate the Device Under Test (DUT)
ClockDivider DUT (
  .ClkIn  (Clk),
  .Enable (Enable),
  .ClkOut (ClkOut)
);

initial begin
  #10 Enable = 'b0;
  #10 Enable = 'b1;

  // Terminate the simulation after 200 time steps  
  #200 $stop;
end

always begin
  #1  Clk = 'b1;
  #1  Clk = 'b0;
end

endmodule