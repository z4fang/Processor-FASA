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
integer  op1, op2;

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

$display("Starting!");

op= 'b000;   //reduction xor
 for(op1=230; op1<256; op1++)begin
   for(op2=230; op2<256; op2++)begin
    INPUTA = op1;
    INPUTB = op2;
    test_alu_func;
    #5;
    end
   end

/*op= 'b000;   //add
 for(op1=0; op1<256; op1++)begin
   for(op2=0; op2<256; op++)begin
    INPUTA = op1;
    INPUTB = op2;
    test_alu_func;
    #5;
    end
   end
 
op= 'b111; //and
 for(op1=0; op1<256; op1++)begin
   for(op2=0; op2<256; op++)begin
    INPUTA = op1;
    INPUTB = op2;
    test_alu_func;
    #5;
    end
   end

 op= 'b010;  // Or
 for(op1=0; op1<256; op1++)begin
   for(op2=0; op2<256; op++)begin
    INPUTA = op1;
    INPUTB = op2;
    test_alu_func;
    #5;
    end
   end

op= 'b101; //branch
 for(op1=0; op1<256; op1++)begin
    INPUTA = op1;
    INPUTB = op2;
    test_alu_func;
    #5;
   end

 op= 'b110; //sll
 for(op1=0; op1<256; op1++)begin
   for(op2=0; op2<256; op++)begin
    INPUTA = op1;
    INPUTB = op2;
    test_alu_func;
    #5;
    end
   end */

 end


 task test_alu_func;
 begin
   case (op)
  0: expected = INPUTA + INPUTB;     // ADD 
  1: expected = ^INPUTB;             // reduction xor
  2: expected =  INPUTA | INPUTB;    // bit wise or
  3: expected = INPUTB;              // load
  4: expected = INPUTA;              // store
  5: expected = INPUTA > 0;          // Bgtz
  6: expected = INPUTA << INPUTB;    // Sll
  7: expected = INPUTA & INPUTB;     // and
  //1: expected = {INPUTA[6:0], SC_IN};  // LSH
  //2: expected = {1'b0, INPUTA[7:1]};  // RSH
  //3: expected = INPUTA ^ INPUTB;  // XOR
  //4: expected = INPUTA & INPUTB;     //AND
  //5: expected = INPUTA - INPUTB;   // SUB

   endcase
   #1; if(expected == OUT)
  begin
   $display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
  end
     else begin $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);end

 end
 endtask

endmodule