module curve_stx_ve_300_20260111_225504_761345_w49296_attempt11 (
  input wire clk,
  output reg [3:0] out_val
);

  // Declare a register variable.
  reg [7:0] MY_FIXED_VALUE;

  // Use an initial block to set the power-on or simulation initial value.
  // This resolves the SYNTH_89 violation by using a synthesizable construct
  // for initial register values, which are usually mapped to a reset value.
  initial begin
    MY_FIXED_VALUE = 8'hA5;
  end

  // This always block performs the intended re-assignment after initialization.
  always @(posedge clk) begin
    MY_FIXED_VALUE <= 8'h5A;
  end

  // Assign to an output.
  assign out_val = MY_FIXED_VALUE[3:0];

endmodule
