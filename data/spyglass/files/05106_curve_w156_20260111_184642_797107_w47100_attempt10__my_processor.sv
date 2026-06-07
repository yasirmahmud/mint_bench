module my_processor (
  input [3:0] input_bus,  // Standard MSB:LSB port definition
  output [3:0] output_bus
);
  // Assign input to output to ensure 'input_bus' is used and avoid unused signal warnings.
  assign output_bus = input_bus;
endmodule
