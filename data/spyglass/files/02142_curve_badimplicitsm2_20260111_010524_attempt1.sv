module curve_badimplicitsm2_20260111_010524_attempt1 (
  input wire in_sig,
  input wire clk_sig,
  output reg out_posedge_reg,
  output reg out_negedge_reg
);

  always begin
    @(posedge clk_sig) begin
      out_posedge_reg <= in_sig;
    end
    @(negedge clk_sig) begin
      out_negedge_reg <= ~in_sig;
    end
  end

endmodule
