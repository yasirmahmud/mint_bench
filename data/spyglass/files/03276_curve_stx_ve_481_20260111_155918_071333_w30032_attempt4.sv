module curve_stx_ve_481_20260111_155918_071333_w30032_attempt4 (
  input wire clk,
  output reg out_data
);

// This 'always' block demonstrates an illegal use of 'else'.
// The 'else' keyword does not follow an 'if' statement.
always @(posedge clk) begin
  out_data <= 1'b0; // This is a procedural assignment
  else // STX_VE_481: Illegal use of Verilog keyword 'else' here.
    out_data <= 1'b1;
end

endmodule
