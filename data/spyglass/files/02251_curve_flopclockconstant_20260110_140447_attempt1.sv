module curve_flopclockconstant_20260110_140447_attempt1 (
  input d,
  output reg q1,
  output reg q2
);

  wire clk_const = 1'b0;

  always @(posedge clk_const) begin
    q1 <= d;
  end

  always @(posedge clk_const) begin
    q2 <= ~d;
  end

endmodule
