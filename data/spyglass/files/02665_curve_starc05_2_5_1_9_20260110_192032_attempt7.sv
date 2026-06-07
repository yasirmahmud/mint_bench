module curve_starc05_2_5_1_9_20260110_192032_attempt7 (
  input wire sel,
  input wire data_in,
  output tri out_tri,
  output reg result1,
  output reg result2
);

  // Define the tri-state output
  assign out_tri = sel ? 1'bz : data_in;

  // First casez statement using out_tri, triggering a violation
  always @(*) begin
    casez (out_tri) // Violation 1: Tri-state output 'out_tri' used in casez select expression
      1'b0: result1 = 1'b0;
      1'b1: result1 = 1'b1;
      default: result1 = 1'bx;
    endcase
  end

  // Second casez statement using the same out_tri, triggering another violation
  always @(*) begin
    casez (out_tri) // Violation 2: Tri-state output 'out_tri' used in casez select expression
      1'b0: result2 = 1'b1;
      1'b1: result2 = 1'b0;
      default: result2 = 1'bx;
    endcase
  end

endmodule
