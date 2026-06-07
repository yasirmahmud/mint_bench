module blkseq_ex3 (
  input clk,
  input set,
  output reg flag
);

  always_ff @(posedge clk) begin
    if (set) begin
      flag = 1'b1; // Triggers BLKSEQ
    end else begin
      flag = 1'b0;
    end
  end

endmodule
