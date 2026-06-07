module curve_stx_ve_481_20260111_155918_071333_w30032_attempt5 (
  input wire clk,
  input wire in_a,
  output reg out_data
);

always @(posedge clk) begin
  if (in_a) begin
    out_data <= 1'b1;
  end
  // The assignment below breaks the 'if-else' construct.
  // This makes the subsequent 'else' illegal as it does not follow an 'if'.
  out_data <= 1'b0;
  else begin // STX_VE_481: Syntax error near 'else' - Illegal use of Verilog keyword 'else'
    out_data <= 1'b0;
  end
end

endmodule
