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
  input        [ 3:0] Addr,
  output logic [ 8:0] Target
);

always_comb begin

  case(Addr)
    4'b0001: Target = 8'b00000100; // Start Loop of Prog 1
    4'b0011: Target = 8'b10011110; // 158 - Prog 2 addr of 1 error
    4'b0010: Target = 8'b11010000; // 208 - Prog 2 add of 2 error
	  4'b0100: Target = 8'b11011111; // 223 - end of prg 2
	  4'b0101: Target = 8'b01111101; // 125 - prog 2 addr of write back;
	  4'b0111: Target = 8'b10111011; // 187 - prg 2 addr of MSB;
    4'b1000: Target = 8'b00000101; // 5 - Start Loop of prog2
    4'b1001: Target = 8'b00010100; // 20 - prog 3 - start loop 
    4'b1011: Target = 8'b01101100; // 108 - prog 3 - start loop of part 3 
	  //2'b1000: Target = 8'b10111011;
    default: Target = 8'b11111111; 
  endcase
end

endmodule
