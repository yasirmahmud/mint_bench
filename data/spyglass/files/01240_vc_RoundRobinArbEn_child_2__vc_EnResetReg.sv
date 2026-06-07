// This module implements an enabled reset register.
module vc_EnResetReg #(
  parameter p_width       = 2,
  parameter p_reset_value = 1 // Default reset value (e.g., 1 for 0...01_b)
)
(
  input                  clk,
  input                  reset,
  input                  en,
  input  [p_width-1:0]   d,
  output [p_width-1:0]   q
);

  reg [p_width-1:0] q_reg;

  always @( posedge clk or posedge reset ) begin
    if ( reset ) begin
      q_reg <= p_reset_value;
    end
    else if ( en ) begin
      q_reg <= d;
    end
  end

  assign q = q_reg;

endmodule
