module my_sub_module (
  input sub_clk,
  input [7:0] sub_data_in,
  output [7:0] sub_data_out
);
  assign sub_data_out = sub_data_in + 1;
endmodule
