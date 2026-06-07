module curve_stx_ve_850_20260111_124711_attempt5 (
  input wire clk,
  input wire rst_n,
  output reg out_reg
);

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= 1'b1;
    end
  end

endmodule
