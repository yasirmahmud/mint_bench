module another_module (
  input wire clk,
  output wire data_out,
  input wire clk // Redeclaration of clk
);
  assign data_out = clk;
endmodule
