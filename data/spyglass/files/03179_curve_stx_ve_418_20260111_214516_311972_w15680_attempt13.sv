module curve_stx_ve_418_20260111_214516_311972_w15680_attempt13 (
  input wire data_in,
  output wire data_out
);

  // Declare an internal wire. This wire represents the output of some internal logic.
  wire internal_data_node;
  assign internal_data_node = data_in; // This continuous assignment acts as an internal 'gate' driving the wire.

  // Connect the internal node to the output port to ensure 'data_out' is used.
  assign data_out = internal_data_node;

  specify
    // STX_VE_418 violation occurs here:
    // 'data_in' is a primary input port and is used directly as the source
    // of a timing path in the specify block. The rule requires that the source
    // of a path must be driven by an internal gate output, not directly by a primary input.
    (data_in => internal_data_node) = 1ps;
  endspecify

endmodule
