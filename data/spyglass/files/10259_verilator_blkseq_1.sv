module blkseq_ex1 (
  input clk,
  input rst_n,
  input d_in,
  output reg q_out
);

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q_out = 1'b0;
    end else begin
      q_out = d_in; // Triggers BLKSEQ
    end
  end

endmodule
