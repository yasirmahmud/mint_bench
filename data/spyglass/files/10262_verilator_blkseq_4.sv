module blkseq_ex4 (
  input clk,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] sum
);

  always @(posedge clk) begin
    sum = a + b; // Triggers BLKSEQ
  end

endmodule
