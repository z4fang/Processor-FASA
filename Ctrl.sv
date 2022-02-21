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
assign MemWrEn = Instruction[8:6] == 3'b100;  //100 = store inst

//assign RegWrEn = Instruction[8:7] != 2'b11;
assign LoadInst = Instruction[8:6] == 3'b011;  // 011 = load instr

// reserve instruction = 9'b111111111; for Ack , done instruction
assign Ack = &Instruction; 

// jump on right shift that generates a zero
// equiv to simply: assign Jump = Instruction[2:0] == RSH;
always_comb begin
   if(Instruction[8:6] == kADD) begin    //add
      RegWrEn = 1;
      Jump = 0;
      BranchEn = 0;
    end

    else if(Instruction[8:6] == kOR) begin //or
      RegWrEn = 1;
      Jump = 0;
      BranchEn = 0;
    end

    else if(Instruction[8:6] == kLOD) begin //load
      RegWrEn = 1;
      Jump = 0;
      BranchEn = 0;
    end
    
    else if(Instruction[8:6] == kSTR) begin // Store
      RegWrEn = 0;
      Jump = 0;
      BranchEn = 0;
    end

    else if(Instruction[8:6] == kBGZ) begin  //Load
      RegWrEn = 1;
      Jump = (Instruction[5:3] > 0) ? 1'b1:1'b0;                                  //testing
      BranchEn = 1;
      // do the jump here?
    end

    else if(Instruction[8:6] == kSLL) begin // Shift left logical
      RegWrEn = 1;
      Jump = 0;
      BranchEn = 0;
    end

    else if(Instruction[8:6] == kAND) begin // and
      RegWrEn = 1;
      Jump = 0;
      BranchEn = 0;
    end

    else begin //reduction XOR
      RegWrEn = 1;
      Jump = 0;
      BranchEn = 0;
    end 
end

// branch every time instruction = 9'b?????1111;
//assign BranchEn = &Instruction[3:0];

// Maybe define specific types of branches?
assign TargSel  = Instruction[3:2];

endmodule
