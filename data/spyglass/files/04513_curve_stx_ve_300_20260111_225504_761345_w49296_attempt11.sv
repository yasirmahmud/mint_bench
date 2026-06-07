module curve_stx_ve_300_20260111_225504_761345_w49296_attempt11 (
  input wire clk,
  output reg [3:0] out_val
);

  // Declare a register variable with an initial value.
  // SpyGlass is expected to interpret 'MY_FIXED_VALUE' as a 'const variable'
  // because it is initialized at declaration and subsequent assignments
  // are typically disallowed for such inferred constants.
  reg [7:0] MY_FIXED_VALUE = 8'hA5;

  // This always block attempts to re-assign a new value to MY_FIXED_VALUE.
  // This procedural assignment to a variable that SpyGlass considers 'const'
  // will trigger the STX_VE_300 violation.
  always @(posedge clk) begin
    // STX_VE_300: Illegal re-assignment to const variable 'MY_FIXED_VALUE'
    MY_FIXED_VALUE <= 8'h5A;
  end

  // Assign to an output to avoid unused signal warnings.
  assign out_val = MY_FIXED_VALUE[3:0];

endmodule
