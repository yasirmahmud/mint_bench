module curve_w422_20260111_191835_499042_w47100_attempt7 (
  input clk1,
  input clk2,
  input data_in,
  output reg data_out
);

  // W422 violation: Event control has more than one clock (clk1 and clk2).
  always @(posedge clk1 or posedge clk2) begin
    data_out <= data_in;
  end

endmodule
