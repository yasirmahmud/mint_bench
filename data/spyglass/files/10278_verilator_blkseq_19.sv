module blkseq_ex19 (
  input clk,
  input rst_n,
  input d_bit,
  output reg q_bit
);

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q_bit = 1'b0;
    end else if (d_bit) begin
      q_bit = 1'b1; // Triggers BLKSEQ
    end else begin
      q_bit = 1'b0;
    end
  end

endmodule
