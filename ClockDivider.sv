// CSE 141L
//
// Simple clock divider

module ClockDivider (
  input        ClkIn,
  input        Enable,
  output logic ClkOut
);

// How do you turn this into a /4 CLK?
// What about a /3 CLK?

always_ff @( posedge ClkIn ) begin : dividerBlock
    if (Enable) begin
        ClkOut <= ~ClkOut;
    end
    // If you delete this other case, what happens?
    if (~Enable) begin
        ClkOut <= '0;
    end
end

endmodule