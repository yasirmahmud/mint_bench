module blkseq_ex14 (
  input clk,
  input rst_n,
  input inc,
  output reg [7:0] count
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count = 8'h00;
    end else if (inc) begin
      count = count + 1; // Triggers BLKSEQ
    end
  end

endmodule
