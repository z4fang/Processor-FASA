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
  output logic       //Jump,
                     BranchEn, // branch at all?
                     RegWrEn,  // write to reg_file (common)
                     MemWrEn,  // write to mem (store only)
                     LoadInst, // mem or ALU to reg_file ?
                     Ack,      // "done with program"
  //output logic [1:0] TargSel   // how to target branch (maybe?)
);

// What follows is instruction decoding.
// This codifies much of your ISA definition!
//
// Note: This **starter code** is not a complete ISA!



assign MemWrEn = Instruction[7:4] == 4'b0100;  //0100 = store inst
assign LoadInst = Instruction[7:4] == 4'b0011;  //0011 = load instr

// reserve instruction = 9'b111111111; for Ack , done instruction
assign Ack = &Instruction;  

// jump on right shift that generates a zero
// equiv to simply: assign Jump = Instruction[2:0] == RSH;
always_comb begin
   if(Instruction[7:4] == kSTR) begin
      BranchEn = 0;
      RegWrEn = 0;
      MemWrEn = 1;
      LoadInst = 0;
    end

    else if(Instruction[7:4] == kLOD) begin
      BranchEn = 0;
      RegWrEn = 1;
      MemWrEn = 0;
      LoadInst = 1;
    end

    else if(Instruction[7:4] == kBNE || Instruction[7:4] == kBEQ ) begin
      BranchEn = 1;
      RegWrEn = 0;
      MemWrEn = 0;
      LoadInst = 0;
    end
    
    else begin
      BranchEn = 0;
      RegWrEn = 1;
      MemWrEn = 0;
      LoadInst = 0;
    end

    
end

// branch every time instruction = 9'b?????1111;
//assign BranchEn = &Instruction[3:0];

// Maybe define specific types of branches?
//assign TargSel  = Instruction[3:2];

endmodule
