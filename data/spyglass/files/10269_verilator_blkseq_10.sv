module blkseq_ex10 (
  input clk,
  input rst,
  input [4:0] addr_in,
  output reg [4:0] addr_reg
);

  always @(posedge clk) begin
    if (rst) begin
      addr_reg = 5'b0;
    end else begin
      addr_reg = addr_in; // Triggers BLKSEQ
    end
  end

endmodule
