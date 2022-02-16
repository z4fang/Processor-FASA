// CSE141L
import definitions::*;
// control decoder (combinational, not clocked)
// inputs from instrROM, ALU flags
// outputs to program_counter (fetch unit)
module Ctrl (
  input[ 8:0] Instruction,	   // machine code
  output logic Jump     ,
               BranchEn ,
	       RegWrEn  ,	   // write to reg_file (common)
	       MemWrEn  ,	   // write to mem (store only)
	       LoadInst	,	   // mem or ALU to reg_file ?
      	       StoreInst,          // mem write enable
	       Ack,		   // "done w/ program"
  output logic [1:0] TargSel       // Select signal for LUT
  );

//assign MemWrEn = Instruction[8:6]==3'b110;	 //111  110
//assign StoreInst = Instruction[8:6]==3'b110;  // calls out store specially

//assign RegWrEn = Instruction[8:7]!=2'b11;  // !111  !110 
//assign LoadInst = Instruction[8:6] == 3'b011;
// reserve instruction = 9'b111111111; for Ack

// jump on right shift that generates a zero
// equiv to simply: assign Jump = Instrucxtion[2:0] == kRSH;
always_comb begin
  /*if(Instruction[2:0] ==  kADD)
    Jump = 1;
  else
    Jump = 0; */

    if(Instruction[8:6] == kADD) begin    //add
      RegWrEn = 1;
      MemWrEn = 0;
      LoadInst = 0;
      StoreInst = 0;
      Jump = 0;
      BranchEn = 0;
    end

    else if(Instruction[8:6] == kOR) begin //or
      RegWrEn = 1;
      MemWrEn = 0;
      LoadInst = 0;
      StoreInst = 0;
      Jump = 0;
      BranchEn = 0;
    end

    else if(Instruction[8:6] == kLOD) begin //load
      RegWrEn = 1;
      MemWrEn = 0;
      LoadInst = 1;
      StoreInst = 0;
      Jump = 0;
      BranchEn = 0;
    end
    
    else if(Instruction[8:6] == kSTR) begin // Store
      RegWrEn = 0;
      MemWrEn = 1;
      LoadInst = 0;
      StoreInst = 1;
      Jump = 0;
      BranchEn = 0;
    end

    else if(Instruction[8:6] == kBGZ) begin  //Load
      RegWrEn = 1;
      MemWrEn = 0;
      LoadInst = 0;
      StoreInst = 0;
      Jump = (Instruction[5:3] > 0) ? 1'b1:1'b0;                                  //testing
      BranchEn = 1;
      // do the jump here?
    end

    else if(Instruction[8:6] == kSLL) begin // Shift left logical
      RegWrEn = 1;
      MemWrEn = 0;
      LoadInst = 0;
      StoreInst = 0;
      Jump = 0;
      BranchEn = 0;
    end

    else if(Instruction[8:6] == kAND) begin // and
      RegWrEn = 1;
      MemWrEn = 0;
      LoadInst = 0;
      StoreInst = 0;
      Jump = 0;
      BranchEn = 0;
    end

    else begin //reduction XOR
      RegWrEn = 1;
      MemWrEn = 0;
      LoadInst = 0;
      StoreInst = 0;
      Jump = 0;
      BranchEn = 0;
    end 

end




// branch every time instruction = 9'b?????1111;
//assign BranchEn = &Instruction[3:0];

// route data memory --> reg_file for loads
//   whenever instruction = 9'b110??????; 
assign TargSel  = Instruction[3:2];

assign Ack = &Instruction;

endmodule




