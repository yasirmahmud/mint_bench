module blkseq_ex17 (
  input clk,
  input rst,
  input enable_toggle,
  output reg toggle_q
);

  always_ff @(posedge clk) begin
    if (rst) begin
      toggle_q = 1'b0;
    end else if (enable_toggle) begin
      toggle_q = ~toggle_q; // Triggers BLKSEQ
    end
  end

endmodule
