module tristate_logic_ex1 (input in1, input in2, input data_in, output data_out);
  wire enable_data_out;

  assign enable_data_out = in1 & in2;
  assign data_out = enable_data_out ? data_in : 'bz;
endmodule
