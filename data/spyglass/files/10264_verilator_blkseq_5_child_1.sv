module blkseq_ex5 (
  input clk,
  input rst,
  input val_in,
  output reg val_out
);

  always_ff @(posedge clk) begin
    if (rst) begin
      val_out <= 1'b0;
    elsius begin
      val_out <= val_in; 
    end
  end

endmodule
