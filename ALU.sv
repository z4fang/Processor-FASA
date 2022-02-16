// Create Date:    2018.10.15
// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision 2021.07.27
// Additional Comments: 
//   combinational (unclocked) ALU
import definitions::*;			          // includes package "definitions"
module ALU #(parameter W=8, Ops=3)(
  input        [W-1:0]   InputA,          // data inputs
                         InputB,
  input        [Ops-1:0] OP,		      // ALU opcode, part of microcode
  input                  SC_in,           // shift or carry in
  output logic [W-1:0]   Out,		      // data output 
  output logic           Zero,            // output = zero flag	 !(Out)
                         Parity,          // outparity flag  ^(Out)
                         Odd			  // output odd flag (Out[0])
// you may provide additional status flags, if desired
    );								    
	 
  op_mne op_mnemonic;			          // type enum: used for convenient waveform viewing
	
  always_comb begin
    Out = 0;                              // No Op = default
    case(OP)							  
      ADD : Out = InputA + InputB;        // add 
      LSH : Out = {InputA[6:0],SC_in};    // shift left, fill in with SC_in 
// for logical left shift, tie SC_in = 0
	  RSH : Out = {1'b0, InputA[7:1]};    // shift right
 	  XOR : Out = InputA ^ InputB;        // bitwise exclusive OR
      AND : Out = InputA & InputB;        // bitwise AND
      SUB : Out = InputA + (~InputB) + 1;
    endcase
  end

  assign Zero   = !Out;                   // reduction NOR
  assign Parity = ^Out;                   // reduction XOR
  assign Odd    = Out[0];				  // odd/even -- just the value of the LSB

  always_comb
    op_mnemonic = op_mne'(OP);			  // displays operation name in waveform viewer

endmodule