// First declaration of 'sensor_interface'
// This serves as the initial definition.
module sensor_interface (
  input wire clk_i,
  input wire rst_ni,
  output wire sdata_o
);

  assign sdata_o = clk_i & rst_ni;

endmodule
