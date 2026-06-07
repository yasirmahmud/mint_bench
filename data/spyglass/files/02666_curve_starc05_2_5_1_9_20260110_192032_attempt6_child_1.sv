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

  // First tri-state output
  assign out_tri_a = sel_a ? 1'bz : data_in_a;

  // Resolved Violation 1: Avoid using tri-state output directly in casez select expression
  always @(*) begin
    if (sel_a == 1'b1) begin // When sel_a is high, out_tri_a is 'z'
      result_a = 1'bx;
    end else begin // When sel_a is low, out_tri_a is data_in_a
      result_a = data_in_a; // This covers 0, 1, and x for data_in_a
    end
  end

  // Second tri-state output
  assign out_tri_b = sel_b ? 1'bz : data_in_b;

  // Resolved Violation 2: Avoid using tri-state output directly in casez select expression
  always @(*) begin
    if (sel_b == 1'b1) begin // When sel_b is high, out_tri_b is 'z'
      result_b = 1'bx;
    end else begin // When sel_b is low, out_tri_b is data_in_b
      result_b = data_in_b; // This covers 0, 1, and x for data_in_b
    end
  end

endmodule
