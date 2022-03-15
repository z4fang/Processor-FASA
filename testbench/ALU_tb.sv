`timescale 1ns/ 1ps

// Test bench
// Arithmetic Logic Unit

//
// INPUT: A, B
// op: 000, A ADD B
// op: 100, A_AND B
// ...
// Please refer to definitions.sv for support ops (make changes if necessary)
// OUTPUT A op B
// equal: is A == B?
// even: is the output even?
//

module ALU_tb;

// Define signals to interface with the ALU module
logic [ 7:0] INPUTA;  // data inputs
logic [ 7:0] INPUTB;
logic [ 3:0] op;      // ALU opcode, part of microcode
bit SC_IN = 'b0;
wire[ 7:0] OUT;
wire Zero;
logic jump;
// Define a helper wire for comparison
logic [ 7:0] expected;

// Instatiate and connect the Unit Under Test
ALU uut(
  .InputA(INPUTA),
  .InputB(INPUTB),
  //.SC_in(SC_IN),
  .OP(op),
  .Out(OUT),
  .jump(jump)
  //.Zero(Zero)
);

// The actual testbench logic
initial begin
  INPUTA = 1;
  INPUTB = 1;
  op= 'b0000; // ADD
  test_alu_func; // void function call
  #5;

  INPUTA = 4;
  INPUTB = 1;
  op= 'b1000; // AND
  test_alu_func; // void function call
  #5;

  INPUTA = 'b00000001;
  INPUTB = 7;
  op= 'b0110; // SRL
  test_alu_func; // void function call
  #5;

  INPUTA = 'b01010001;
  INPUTB = 'b00000111;
  op= 'b1001; // XXR
  test_alu_func; // void function call
  #5;

  INPUTA = 'b01010001;
  INPUTB = 'b01000100;
  op= 'b1001; // XXR
  test_alu_func; // void function call
  #5;

  INPUTA = 'b01010001;
  INPUTB = 'b01000100;
  op= 'b0101; // BNE
  test_alu_func; // void function call
  #5;

  INPUTA = 'b01010001;
  INPUTB = 'b01000100;
  op= 'b1101; // BEQ
  test_alu_func; // void function call
  #5;

  INPUTA = 'b01010001;
  INPUTB = 'b01010001;
  op= 'b1101; // BEQ
  test_alu_func; // void function call
  #5;


end



task test_alu_func;
  case (op)
    0: expected = INPUTA + INPUTB;      // ADD
    1: expected = INPUTA ^ INPUTB;      // XOR
    2: expected = INPUTA | INPUTB;      // ORR
    5: expected = INPUTA != INPUTB;     // BNE
    6: expected = INPUTA << INPUTB;     // SLL
    7: expected = INPUTA >> INPUTB;     // SRL
    8: expected = INPUTA & INPUTB;      // AND
    9: expected = ^{INPUTA,INPUTB};      // reduction XOR
    12: expected = INPUTA - INPUTB;      // SUB
    13: expected = INPUTA == INPUTB;
  endcase
  #1;
  if(expected == OUT) begin
    $display("%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
  end else begin
    $display("%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);
  end
endtask

initial begin
  $dumpfile("alu.vcd");
  $dumpvars();
  $dumplimit(104857600); // 2**20*100 = 100 MB, plenty.
end

endmodule
