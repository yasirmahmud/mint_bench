module blkseq_ex18 (
  input clk,
  input [1:0] control,
  input [10:0] val_x,
  output reg [10:0] reg_out
);

  always @(posedge clk) begin
    if (control == 2'b01) begin
      reg_out = val_x;
    end else if (control == 2'b10) begin
      reg_out = val_x + 1; // Triggers BLKSEQ
    end else begin
      reg_out = 11'h000;
    end
  end

endmodule
