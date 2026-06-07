module synth_5257_example_7 (
  input wire [0:0] data_in_port,
  output wire [0:0] error_output,
  output wire [0:0] normal_output
);

  // SYNTH_5257: CELL_TYPE_SLICE -> Part Select [1:1] on a Vector PORT_ID_IN[0:0] is out of range
  // The input 'data_in_port' is a 1-bit vector, declared with the range [0:0].
  // The part-select expression 'data_in_port[1:1]' attempts to access bit 1,
  // which is outside the declared valid range [0:0] for the port. This directly
  // triggers the SYNTH_5257 violation.
  assign error_output = data_in_port[1:1];

  // The valid bit 'data_in_port[0]' is explicitly read and assigned to 'normal_output'
  // to prevent a 'W240: Input declared but not read' warning, ensuring that
  // only the target SYNTH_5257 rule is triggered if possible.
  assign normal_output = data_in_port[0];

endmodule
