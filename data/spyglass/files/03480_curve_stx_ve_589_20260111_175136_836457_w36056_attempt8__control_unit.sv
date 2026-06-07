module control_unit (
  input wire clk,
  output wire enable
);
  assign enable = clk;
endmodule
