module data_processor (
  input wire clk,
  input wire rst_n,
  output wire done
);
  assign done = clk & rst_n;
endmodule
