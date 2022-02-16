`timescale 1ns/ 1ps

//Test bench
//Arithmetic Logic Unit
/*
* INPUT: A, B
* op: 000, A ADD B
* op: 100, A_AND B
* ...
* Pleaser refer to definitions.sv for support ops(make changes if necessary)
* OUTPUT A op B
* equal: is A == B?
* even: is the output even?
*/


module ALU_tb;
logic [ 7:0] INPUTA;        // data inputs
logic [ 7:0] INPUTB;
logic [ 2:0] op;  // ALU opcode, part of microcode
bit SC_IN = 'b0;
wire[ 7:0] OUT;
wire Zero;
logic [ 7:0] expected;

// CONNECTION
ALU uut(
  .InputA(INPUTA),
  .InputB(INPUTB),
  .SC_in(SC_IN),
  .OP(op),
  .Out(OUT),
  .Zero(Zero)
    );

initial begin

 INPUTA = 1;
 INPUTB = 1;
 op= 'b000; // ADD
 test_alu_func; // void function call
 #5;


 INPUTA = 4;
 INPUTB = 1;
 op= 'b100; // AND
 test_alu_func; // void function call
 #5;
 end

 task test_alu_func;
 begin
   case (op)
  0: expected = INPUTA + INPUTB;  // ADD 
  1: expected = {INPUTA[6:0], SC_IN};  // LSH
  2: expected = {1'b0, INPUTA[7:1]};  // RSH
  3: expected = INPUTA ^ INPUTB;  // XOR
  4: expected = INPUTA & INPUTB;     //AND
  5: expected = INPUTA - INPUTB;   // SUB
   endcase
   #1; if(expected == OUT)
  begin
   $display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
  end
     else begin $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);end

 end
 endtask

endmodule