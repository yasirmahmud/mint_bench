module blkseq_ex13 (
  input clk,
  input [1:0] mode,
  input [9:0] d_a,
  input [9:0] d_b,
  output reg [9:0] result
);

  always_ff @(posedge clk) begin
    if (mode == 2'b00) result = d_a;
    else if (mode == 2'b01) result = d_b;
    else result = d_a + d_b; // Triggers BLKSEQ
  end

endmodule
