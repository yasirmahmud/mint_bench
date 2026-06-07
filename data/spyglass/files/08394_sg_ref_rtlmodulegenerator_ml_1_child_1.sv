module sub_module_ex1 (
  input wire [WIDTH-1:0] data_in,
  output wire [WIDTH-1:0] data_out
);
  parameter WIDTH = 1; // Default value, will be overridden by instantiation

  // Assign data_out to data_in for a minimal functional definition.
  // Since data_out is unconnected in the parent module, this assignment
  // does not affect the parent's observable behavior.
  assign data_out = data_in;

endmodule
