module curve_synth_5290_20260112_012517_094977_w37744_attempt16 (
  input wire clk,
  input wire reset,
  output reg [7:0] data_out
);

  // Declare a real local parameter. While the declaration itself might be tolerated
  // by some tools, the usage of a 'real' value in a synthesizable context will cause a violation.
  real SCALE_FACTOR = 3.14159265; 

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      data_out <= 8'd0;
    end else begin
      // SYNTH_5290 violation: Attempting to assign a 'real' parameter (SCALE_FACTOR)
      // to a synthesizable bit-vector 'reg' (data_out) in a sequential block.
      // This usage of a 'real' type is not synthesizable.
      data_out <= SCALE_FACTOR;
    end
  end

endmodule
