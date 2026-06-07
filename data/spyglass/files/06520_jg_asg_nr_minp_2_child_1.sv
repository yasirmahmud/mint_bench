module BadInputAssign2 (
  input [3:0] data_in,
  output wire data_out
);

  // The original code assigned a value to the input port 'data_in',
  // which is illegal and caused SpyGlass violations.
  // The functional behavior was that 'data_in' effectively became 4'hA internally,
  // and 'data_out' became (4'hA)[0], which is 1'b0.
  // To preserve this behavior and fix the violation, we directly assign the derived constant to 'data_out'.
  assign data_out = (4'hA)[0]; // This resolves to 1'b0

endmodule
