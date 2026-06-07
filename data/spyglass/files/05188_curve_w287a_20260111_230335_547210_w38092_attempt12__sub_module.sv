module sub_module (
  input sub_input_port,
  output sub_output_port
);
  // This sub-module simply passes the input to the output.
  // The important part is that 'sub_input_port' is an input that needs a driver.
  assign sub_output_port = sub_input_port;
endmodule
