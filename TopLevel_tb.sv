// Create Date:   2017.01.25
// Design Name:   TopLevel Test Bench
// Module Name:   TopLevel_tb.v
//  CSE141L
// This is NOT synthesizable; use for logic simulation only
// Verilog Test Fixture created for module: TopLevel

module TopLevel_tb;	     // Lab 17

// To DUT Inputs
  bit  Init = 'b1,
       Req,
       Clk;

// From DUT Outputs
  wire Ack;		   // done flag

// Instantiate the Device Under Test (DUT)
  TopLevel DUT (
    .Reset  (Init)  ,
	.Start  (Req )  , 
	.Clk    (Clk )  , 
	.Ack    (Ack )             
	);

initial begin
  #10ns Init = 'b0;
  #10ns Req  = 'b1;
    
// launch prodvgram in DUT
  #10ns Req = 0;
// Wait for done flag, then display results
  wait (Ack);
  #10ns $displayh(DUT.DM1.Core[5],
                  DUT.DM1.Core[6],"_",
                  DUT.DM1.Core[7],
                  DUT.DM1.Core[8]);
//        $display("instruction = %d %t",DUT.PC,$time);
  #10ns $stop;			   
end

always begin   // clock period = 10 Verilog time units
  #5ns  Clk = 'b1;
  #5ns  Clk = 'b0;
end
      
endmodule

