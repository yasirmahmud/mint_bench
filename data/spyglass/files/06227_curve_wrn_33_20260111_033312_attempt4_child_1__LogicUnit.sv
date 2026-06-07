module LogicUnit (
  input wire in_data,
  output wire out_data_inverted
);
  assign out_data_inverted = ~in_data;
endmodule
