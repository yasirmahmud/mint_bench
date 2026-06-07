module my_sub_module (
  input wire in_data,
  output wire out_data
);
  assign out_data = ~in_data;
endmodule
