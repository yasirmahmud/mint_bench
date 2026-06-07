module blkseq_ex20 (
  input clk,
  input [2:0] input_data,
  output reg [2:0] output_reg_a,
  output reg [2:0] output_reg_b
);

  always @(posedge clk) begin
    output_reg_a = input_data; // Triggers BLKSEQ
    output_reg_b = input_data + 1; // Triggers BLKSEQ
  end

endmodule
