module curve_stx_ve_674_20260112_011632_217927_w47152_attempt15 (
  input clk,
  input enable_sig, // First declaration of enable_sig
  input rst_n,
  output reg out_data,
  input enable_sig // Re-declaration of enable_sig triggers STX_VE_674
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    out_data <= 1'b0;
  end else if (enable_sig) begin
    out_data <= 1'b1;
  end else begin
    out_data <= 1'b0;
  end
end

endmodule
