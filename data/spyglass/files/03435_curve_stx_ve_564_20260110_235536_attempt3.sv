module curve_stx_ve_564_20260110_235536_attempt3 (
  input wire [7:0] data_in,
  output wire [7:0] data_out
);

  // Simple assignment to avoid unused port warnings
  assign data_out = data_in;

  // Define a function, intentionally missing 'endfunction'
  function [7:0] get_transformed_val (input [7:0] raw_val, input [2:0] shift_amt);
    get_transformed_val = raw_val << shift_amt;
    // FATAL VIOLATION: Keyword 'endfunction' is missing here.
    // SpyGlass rule STX_VE_564 is expected to trigger at this point.

  // Declare a register after the incomplete function definition
  // to make this example distinct from previous attempts.
  reg [3:0] internal_status;
  initial internal_status = 4'b0000; // Initialize to avoid latch warnings

endmodule
