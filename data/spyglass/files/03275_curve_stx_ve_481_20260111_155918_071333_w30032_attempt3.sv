module curve_stx_ve_481_20260111_155918_071333_w30032_attempt3 (
  input wire clk,
  input wire reset_n,
  input wire in_data,
  output reg out_q
);

reg temp_reg;

always @(posedge clk or negedge reset_n) begin
  if (!reset_n) begin
    out_q <= 1'b0;
    temp_reg <= 1'b0;
  end else begin
    temp_reg <= in_data; // This statement is valid
    // The 'else' keyword below is illegal because it does not directly follow an 'if' statement.
    // It appears after a procedural assignment, triggering STX_VE_481.
    else
      out_q <= temp_reg;
  end
end

endmodule
