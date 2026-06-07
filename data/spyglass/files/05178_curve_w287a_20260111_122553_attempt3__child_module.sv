module child_module (
  input wire input_data,
  output wire output_result
);
  // Simple logic to use the input and drive the output,
  // preventing W240 (unused input) and W528 (undriven output of module).
  assign output_result = input_data;
endmodule
