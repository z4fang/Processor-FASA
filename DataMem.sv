// Create Date:    2017.01.25
// Design Name:    CSE141L
// Module Name:    DataMem
// Last Update:    2022.01.13

// Memory can only read _or_ write each cycle, so there is justi a single
// address pointer for both read and write operations.
//
// Parameters:
//  - A: Address Width. This controls the number of entries in memory
//  - W: Data Width. This controls the size of each entry in memory
// This memory can hold `(2**A) * W` bits of data.
//
// WI22 is a 256-entry single-byte (8 bit) data memory.
module DataMem #(parameter W=8, A=8) (
  input                 Clk,
                        Reset,
                        WriteEn,    // writing mem
  input       [A-1:0]   DataAddress, // A-bit-wide pointer to 256-deep memory
  input       [W-1:0]   DataIn,      // W-bit-wide data path, also
  output logic[W-1:0]   DataOut
);

// 8x256 two-dimensional array -- the memory itself
logic [W-1:0] Core[0:2**A-1];

// reads are combinational
always_comb
  DataOut = Core[DataAddress];

// Load the initial contents of memory
initial begin
  //$readmemh("../data_mem.hex", Core);
end

// writes are sequential
always_ff @ (posedge Clk)
  /*
  // Reset response is needed only for initialization.
  // (see inital $readmemh above for another choice)
  //
  // If you do not need to preload your data memory with any constants,
  // you may omit the `if (Reset) ... else` and go straight to `if(WriteEn)`
  */

  //if(Reset) begin
    // Usually easier to initialize memory by reading from file, as above.
  //end 
  if(WriteEn) begin
    // Do the actual writes
    Core[DataAddress] <= DataIn;
  end
endmodule
