module blkseq_ex8 (
  input clk,
  input rst_n,
  input d_val,
  output reg q_val,
  output reg q_next_val
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q_val = 1'b0;
      q_next_val = 1'b0;
    end else begin
      q_val = d_val; // Triggers BLKSEQ
      q_next_val = q_val; // Triggers BLKSEQ
    end
  end

endmodule
