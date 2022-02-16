// Design Name:    CSE141L
// Module Name:    LUT

// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
// Lookup table acts like a function: here Target = f(Addr);
// in general, Output = f(Input)
//
// Lots of potential applications of LUTs!!

// You might consider parameterizing this!
module LUT(
  input        [ 1:0] Addr,
  output logic [ 9:0] Target
);

always_comb begin

  case(Addr)
    2'b00: Target = 10'h3f0; // -16, i.e., move back 16 lines of machine code
    2'b01: Target = 10'h003;
    2'b10: Target = 10'h007;
    2'b11: Target = 10'h001; // default to 1 (or PC+1 for relative)
  endcase
end

endmodule
