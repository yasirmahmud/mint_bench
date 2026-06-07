module my_block (
  input wire clk_in,
  output wire clk_out
);
  parameter DIV_FACTOR = 1;

  assign clk_out = clk_in;
endmodule
