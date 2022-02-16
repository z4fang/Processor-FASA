//PC (First half of fetch)
module ProgCtr_tb;
//`timescale 1ns/ 1ps
`timescale 1ns/ 1ps
// 1000ps = 1 ns
bit Reset, Start, Clk, BranchAbsEn, BranchRelEn, ALU_flag;
bit [9:0] Target;
logic [9:0] ProgCtr_o;

ProgCtr uut (
    .Reset(Reset),
    .Start(Start),
    .Clk(Clk),
    .BranchAbs(BranchAbsEn),
    .BranchRel(BranchRelEn),
    .ALU_flag(ALU_flag),
    .Target(Target),
        .ProgCtr(ProgCtr_o)

);

initial begin
    //Time 0
    Reset = '1;
    Start = '0;
    Clk = '0;
    BranchAbsEn = '0;
    BranchRelEn = '0;
    ALU_flag = '0;
    Target = '0;

    //advance time unit, LATCH VALUE
    #1 Clk = '1;
    #1 Clk = '0;
    $display("Check Reset Behavior");
    assert (ProgCtr_o == 'd0); 
    

    //Check reset, advance, next ptrCtr
    //Check nothing happen before start
    // 2/2 lecture

end

endmodule