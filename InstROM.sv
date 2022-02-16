// Create Date:    15:50:22 10/02/2019 
// Design Name: 
// Module Name:    InstROM 
// Project Name:   CSE141L
// Tool versions: 
// Description: Verilog module -- instruction ROM template	
//	 preprogrammed with instruction values (see case statement)
//
// Revision: 2020.08.08
//
module InstROM #(parameter A=10, W=9) (
  input       [A-1:0] InstAddress,
  output logic[W-1:0] InstOut);
	 
// Sample instruction format: 
//   {3bit opcode, 3bit rs or rt, 3bit rt, immediate, or branch target}
//   then use LUT to map 3 bits to 10 for branch target, 8 for immediate	 

// First option - manually populating instructions
  always_comb begin 
	InstOut = 'b000_000_000;        // default
	case (InstAddress)
//opcode = 3 load, rs = 1, rt = 0, reg[rs] = mem[reg[rt]]
      0 : InstOut = 'b011_001_000;  // load from address at reg 0 to reg 1  

// opcode = 3 load, rs = 3, rt = 4, reg[rs] = mem[reg[rt]]
      1 : InstOut = 'b011_011_100;  // load from address at reg 4 to reg 3
		
// opcode = 0 add, rs = 1, rt = 3, reg[rs] = reg[rs]+reg[rt]
      2 : InstOut = 'b000_001_011;  // add reg 1 and reg 3
		
// opcode = 6 store, rs = 1, rt = 0, mem[reg[rt]] = reg[rs]
      3 : InstOut = 'b110_001_000;  // write reg 1 to address at reg 0
		
// opcode = 15 halt
      4 : InstOut = '1;  // equiv to 10'b1111111111 or 'b1111111111    halt
// (default case already covered by opening statement)
    endcase
  end

/* Uncomment this part if reading from machine_code.txt
// Second option (usually recommended) alternative expression
//   need $readmemh or $readmemb to initialize all of the elements
// declare 2-dimensional array, W bits wide, 2**A words deep
  logic[W-1:0] inst_rom[2**A];
  always_comb InstOut = inst_rom[InstAddress];

  // Load instruction memory from external file
  initial begin
  	// NOTE: This may not work depending on your simulator
	//       e.g. Questa needs the file in path of the application .exe, it
	//       doesn't care where you project code is
	//$readmemb("machine_code.txt",inst_rom);
	
	// So you are probably better off with an absolute path,
	// but you will have to change this example path when you
	// try this on your machine most likely:
	//$readmemb("//vmware-host/Shared Folders/Downloads/basic_proc2/machine_code.txt", inst_rom);
  end 
*/
  
endmodule
