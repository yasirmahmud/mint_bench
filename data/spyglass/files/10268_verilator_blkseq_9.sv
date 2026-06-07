module blkseq_ex9 (
  input clk,
  input enable,
  output reg state
);

  always_ff @(posedge clk) begin
    if (enable) begin
      state = ~state; // Triggers BLKSEQ
    end
  end

endmodule
