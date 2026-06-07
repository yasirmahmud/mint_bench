module data_processor (
  input  processed_enable,
  input  raw_data_in,
  output processed_out
);
  assign processed_out = raw_data_in & processed_enable;
endmodule
