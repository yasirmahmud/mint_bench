module blkseq_ex2 (
  input clk,
  input en,
  input [3:0] data_in,
  output reg [3:0] data_out
);

  always @(posedge clk) begin
    if (en) begin
      data_out = data_in; // Triggers BLKSEQ
    end
  end

endmodule
