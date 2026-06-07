module curve_stx_ve_485_example (
  output wire [7:0] out_data
);

  // STX_VE_485 violation: This include file will not be found.
  `include "my_missing_header.v"

  // Minimal logic to ensure no other errors and a functional (though trivial) module.
  assign out_data = 8'hAA;

endmodule
