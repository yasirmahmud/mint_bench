module top ();

  // This include file does not exist, triggering STX_VE_485
  `include "non_existent_params.v"

  // Minimal valid Verilog to complete the module without generating other errors
  wire [7:0] internal_data;
  assign internal_data = 8'h00;

endmodule
