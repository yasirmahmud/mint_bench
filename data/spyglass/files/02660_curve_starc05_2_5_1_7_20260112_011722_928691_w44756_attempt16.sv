module curve_starc05_2_5_1_7_20260112_011722_928691_w44756_attempt16 (
  input wire data_i,
  input wire enable_i,
  input wire control_i,
  output tri tri_out_o,
  output reg logic_out_o
);

  // Drive the tri-state output 'tri_out_o'.
  // This 'assign' statement defines 'tri_out_o' as a tri-state signal,
  // meaning it can be driven to 0, 1, or Z.
  assign tri_out_o = enable_i ? data_i : 1'bz;

  // Use the tri-state output in an 'if' condition to trigger the violation.
  always @(*) begin
    // Default assignment to avoid latch inference in 'logic_out_o'
    logic_out_o = 1'b0;

    // STARC05-2.5.1.7 violation: Tri-state output 'tri_out_o' used directly
    // in the conditional expression of an 'if' statement.
    if (tri_out_o) begin // This is the exact violation point for STARC05-2.5.1.7
      logic_out_o = control_i;
    end else begin
      logic_out_o = ~control_i;
    end
  end

endmodule
