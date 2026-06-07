module unlabeled_assert_example (
  input clk,
  input rst_n,
  input enable,
  input data_in
);

  always @(posedge clk) begin
    if (!rst_n) begin
      // Reset logic
    end else begin
      assert property (@(posedge clk) enable |-> data_in);
    end
  end

endmodule
