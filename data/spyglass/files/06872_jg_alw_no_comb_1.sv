module latch_example_1 (
  input logic in_a,
  input logic in_b,
  output logic out_latch
);

  always_comb begin
    if (in_a) begin
      out_latch = in_b;
    end
    // Latch inferred for out_latch if in_a is 0
  end

endmodule
