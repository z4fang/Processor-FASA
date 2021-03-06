// Create Date:    2019.01.25
// Last Update:    2022.01.13
// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

// n.b. parameters are compile time directives this can be an any-width,
// any-depth `reg_file`: just override the params!
//   W = data path width          <-- [WI22 Requirement: max(W)=8]
//   A = address pointer width    <-- [WI22 Requirement: max(A)=4]
import Definitions::*;
module RegFile #(parameter W=8, A=4)(
  input                Clk,
  input                Reset,
  input                WriteEn,   // write reg
  input                Op,         // I type?
  input          [3:0] Operation,  // Store, Load, CPP, CYY
  input        [A-1:0] Rtaddr,    // regsiter address of rs/rt
  //input        [A-1:0] Waddr,     // address pointers
  input        [W-1:0] DataIn,    // data for registers
  input        [W-1:0] Immediate, // load immediate
  output logic [W-1:0] DataOutA,  //  Operand1
  output logic [W-1:0] DataOutB   //  Operand2
  //output logic [W-1:0] DataOutTarget // contain address for branching
  //output logic [W-1:0] DataOutReadAdd
);


// W bits wide [W-1:0] and 2**A registers deep
//   When W=8 bit wide registers and A=4 to address 16 registers
//   then this could be written `logic [7:0] registers[16]`
logic [W-1:0] Registers[2**A];


// combinational reads
//
// Could write `always_comb` block in place of assign
//   difference: assign is limited to one line of code,
//   so `always_comb` is much more versatile

// This is ARM-style registers (i.e. r0 is general purpose)
//assign DataOutA = (Operation==kSTR)?Registers[Rtaddr]:Registers[1];       //ALU operand 1
//assign DataOutB = Registers[2];       //ALU operand 2
//assign DataOutTarget = Registers[Rtaddr]; // for branch
//assign DataOutReadAdd = Registers[0];  // r0 = mem address

always_comb begin
  if(Operation==kSTR || Operation == kLOD) begin 
    DataOutA <= Registers[Rtaddr];
    DataOutB <= Registers[0];
  end

  else if(Operation == kBNE || Operation == kBGT) begin 
    DataOutA <= Registers[1];
    DataOutB <= Registers[2];
  end

  else begin
    DataOutA <= Registers[1];
    DataOutB <= Registers[2];
  end


end
// This is MIPS-style registers (i.e. r0 is always read-as-zero)
always_ff @(posedge Clk)begin
  if (Reset) begin
    for (int i=0; i<2**A; i=i+1) begin
      Registers[i] <= '0;
    end
  end

  else if(WriteEn) begin
    if(Op == 1) begin             // load imm
      Registers[3] <= Immediate;     // r3 special reg for load imm
    end

    else if(Operation == kLOD) begin
      Registers[Rtaddr] <= DataIn;
    end

    else if(Operation == kCPP) begin
      Registers[1] <= Registers[Rtaddr];
    end

    else if(Operation == kCYY) begin
      Registers[2] <= Registers[Rtaddr];
    end

    else Registers[Rtaddr] <= DataIn;
  end
end

// FIXME: ^^ Careful! ^^
//   You probably don't want different register output
//   ports to behave differently in your final design!!
//
//   ... or maybe you do, can be a neat trick for more
//   compact encoding to have them behave different...
//   (but almost certainly not exactly like this)


// sequential (clocked) writes
//
// Works just like data_memory writes

/*always_ff @ (posedge Clk) begin
  integer i;
  if (Reset) begin
    for (i=0; i<2**A; i=i+1) begin
      Registers[i] <= '0;
    end
  end else if (WriteEn) begin
    Registers[Waddr] <= DataIn;
  end
end */


endmodule
