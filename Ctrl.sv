// Project Name:   CSE141L
// Module Name:    Ctrl
// Create Date:    ?
// Last Update:    2022.01.13

// control decoder (combinational, not clocked)
// inputs from ... [instrROM, ALU flags, ?]
// outputs to ...  [program_counter (fetch unit), ?]
import Definitions::*;

// n.b. This is an example / starter block
//      Your processor **will be different**!
module Ctrl (
  input  [8:0] Instruction,    // machine code
                               // some designs use ALU inputs here
  output logic       Jump,
                     BranchEn, // branch at all?
                     RegWrEn,  // write to reg_file (common)
                     MemWrEn,  // write to mem (store only)
                     LoadInst, // mem or ALU to reg_file ?
                     Ack,      // "done with program"
  output logic [1:0] TargSel   // how to target branch (maybe?)
);

// What follows is instruction decoding.
// This codifies much of your ISA definition!
//
// Note: This **starter code** is not a complete ISA!


// instruction = 9'b110??????;
assign MemWrEn = Instruction[8:6] == 3'b110;

assign RegWrEn = Instruction[8:7] != 2'b11;
assign LoadInst = Instruction[8:6] == 3'b011;

// reserve instruction = 9'b111111111; for Ack
assign Ack = &Instruction;

// jump on right shift that generates a zero
// equiv to simply: assign Jump = Instruction[2:0] == RSH;
always_comb begin
  if(Instruction[2:0] == RSH) begin
    Jump = 1;
  end else begin
    Jump = 0;
  end
end

// branch every time instruction = 9'b?????1111;
assign BranchEn = &Instruction[3:0];

// Maybe define specific types of branches?
assign TargSel  = Instruction[3:2];

endmodule
