module test_cov_nr_impl_2 (
  input clk,
  input rst_n,
  input x,
  input y
);

  always @(posedge clk) begin
    // Dummy logic
  end

  cover property (@(posedge clk) x |=> y);

endmodule
