module blkseq_ex12 (
  input clk,
  input start,
  output reg busy
);

  always @(posedge clk) begin
    if (start) begin
      busy = 1'b1; // Triggers BLKSEQ
    end else begin
      busy = 1'b0;
    end
  end

endmodule
