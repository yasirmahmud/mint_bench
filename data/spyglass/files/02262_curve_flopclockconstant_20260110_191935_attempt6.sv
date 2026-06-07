module curve_flopclockconstant_20260110_191935_attempt6 (
  input d1,
  input d2,
  output reg q1,
  output reg q2
);

  wire clk_const_low = 1'b0;
  always @(posedge clk_const_low) begin
    q1 <= d1;
  end

  wire clk_const_high = 1'b1;
  always @(posedge clk_const_high) begin
    q2 <= d2;
  end

endmodule
