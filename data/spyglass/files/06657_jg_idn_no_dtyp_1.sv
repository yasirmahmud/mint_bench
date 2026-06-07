module implicit_port_types (
  clk,
  reset,
  data_in,
  data_out
);
  input clk;
  input reset;
  input data_in;
  output data_out;

  assign data_out = data_in;
endmodule
