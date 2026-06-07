module curve_stx_ve_300_20260111_225504_761345_w49296_attempt12 (
  input wire clk,
  output reg [3:0] out_data
);

  // Declare a register variable and initialize it at declaration.
  // SpyGlass is expected to interpret 'MY_READ_ONLY_VAL' as a 'const variable'
  // because it is initialized at declaration and potentially intended to hold a fixed value.
  reg [7:0] MY_READ_ONLY_VAL = 8'hF0;

  // This always block attempts a procedural blocking re-assignment to MY_READ_ONLY_VAL.
  // This action, assigning to a variable that SpyGlass considers 'const' (due to its
  // declaration and initialization), is intended to trigger the STX_VE_300 violation.
  // This pattern closely mirrors successful context example #2, which uses a blocking
  // assignment to a 'const' variable within an always @(posedge clk) block.
  always @(posedge clk) begin
    MY_READ_ONLY_VAL = 8'h0F; // STX_VE_300: Illegal re-assignment to const variable 'MY_READ_ONLY_VAL'
  end

  // Assign to an output to avoid unused signal warnings and ensure connectivity.
  assign out_data = MY_READ_ONLY_VAL[3:0];

endmodule
