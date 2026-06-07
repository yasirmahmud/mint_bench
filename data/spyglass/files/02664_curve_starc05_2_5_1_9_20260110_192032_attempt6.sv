module curve_starc05_2_5_1_9_20260110_192032_attempt6 (
  input wire sel_a,
  input wire data_in_a,
  output tri out_tri_a,
  input wire sel_b,
  input wire data_in_b,
  output tri out_tri_b,
  output reg result_a,
  output reg result_b
);

  // First tri-state output and its violation
  assign out_tri_a = sel_a ? 1'bz : data_in_a;

  always @(*) begin
    casez (out_tri_a) // Violation 1: out_tri_a (tri-state output) used in casez select expression
      1'b0: result_a = 1'b0;
      1'b1: result_a = 1'b1;
      default: result_a = 1'bx;
    endcase
  end

  // Second tri-state output and its violation
  assign out_tri_b = sel_b ? 1'bz : data_in_b;

  always @(*) begin
    casez (out_tri_b) // Violation 2: out_tri_b (tri-state output) used in casez select expression
      1'b0: result_b = 1'b0;
      1'b1: result_b = 1'b1;
      default: result_b = 1'bx;
    endcase
  end

endmodule
