module module_prp_nr_alws_2 (
  input clk,
  input rst_n,
  input enable_signal
);

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Reset logic (not directly related to the violation, but common)
    end else begin
      // Another concurrent assertion inside a procedural block
      assert property (@(posedge clk) disable iff (!rst_n) (enable_signal |-> ##1 !enable_signal));
    end
  end

endmodule
