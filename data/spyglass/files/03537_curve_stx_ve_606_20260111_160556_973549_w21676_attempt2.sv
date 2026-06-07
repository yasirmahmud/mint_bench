module curve_stx_ve_606_20260111_160556_973549_w21676_attempt2 (
    input clk,
    input reset,
    output reg out_reg
);

  // Identifier 'c_coeff_2' is used here without being declared,
  // triggering STX_VE_606.
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out_reg <= 1'b0;
    end else begin
      out_reg <= c_coeff_2; // c_coeff_2 is undeclared in this scope
    end
  end

endmodule
