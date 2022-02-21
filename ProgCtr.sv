// Project Name:   CSE141L
// Module Name:    ProgCtr
// Description:    instruction fetch (pgm ctr) for processor
//
// Revision:       2019.01.27
// Last Update:    2022.01.13

// These are **examples** of signals in some processor designs.
// In particular, your branch and target logic may vary.
//
// Parameters:
//  A: Number of address bits in instruction memory
module ProgCtr #(parameter A=10)(
  input                Reset,       // reset, init, etc. -- force PC to 0
                       Start,       // begin next program in series (request issued by test bench)
                       Clk,         // PC can change on pos. edges only
                       BranchAbsEn, // jump unconditionally to Target value
                       BranchRelEn, // jump conditionally to Target + PC
                       ALU_flag,    // flag from ALU, e.g. Zero, Carry, Overflow, Negative (from ARM)
  input        [A-1:0] Target,      // jump ... "how high?"
  output logic [A-1:0] ProgCtr      // the program counter register itself
);


logic [1:0] StartCount;
logic start_r;

// program counter can clear to 0, increment, or jump
always_ff @(posedge Clk) begin
  if(Reset)
    ProgCtr <= 0;                  // for first program; want different value for 2nd or 3rd
  else if(BranchAbsEn)             // unconditional absolute jump
    ProgCtr <= Target;             //   how would you make it conditional and/or relative?
  else if(BranchRelEn && ALU_flag) // conditional relative jump
    ProgCtr <= Target + ProgCtr;   //   how would you make it unconditional and/or absolute
  else
    ProgCtr <= ProgCtr+'b1;        // default increment (no need for ARM/MIPS +4 -- why?)

  // Note about Start:
  //
  // If your programs are spread out, with a gap in your machine code listing,
  // you will want to make Start cause an appropriate jump.
  //
  // If your programs are packed sequentially, such that program 2 begins right
  // after Program 1 ends, then you won't need to do anything special here.

  // Handle the Start signal by overriding normal behavior
  if (Reset) begin
    StartCount <= '0;
    start_r <= '0;
  end else begin
    start_r <= Start;
    // Detect rising edge of Start
    if ((start_r == '0) && (Start == '1)) begin
      StartCount <= StartCount + 1'b1;
    end
    // Detect falling edge of Start
    if ((start_r == '1) && (Start == '0)) begin
      case (StartCount)
        1: ProgCtr <= 'd000;   // program 1
        2: ProgCtr <= 'd400;   // program 2
        3: ProgCtr <= 'd800;   // program 3
        // when start == 3, terminate simulation
        default: ProgCtr <= ProgCtr;
      endcase
    end
    // And generally, don't let things go anywhere until first Start
    if (StartCount == '0)
      ProgCtr <= ProgCtr;
  end
end

endmodule
