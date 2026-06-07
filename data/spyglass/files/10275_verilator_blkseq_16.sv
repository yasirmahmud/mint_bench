module blkseq_ex16 (
  input clk,
  input [5:0] in_val,
  output reg [5:0] out_val_a,
  output reg [5:0] out_val_b
);

  always @(posedge clk) begin
    out_val_a = in_val; // Triggers BLKSEQ
    out_val_b = out_val_a; // Triggers BLKSEQ
  end

endmodule
