module curve_stx_ve_564_20260110_235536_attempt2 (
  input wire [3:0] in_data,
  output wire [3:0] out_data
);

  // Use the input/output to avoid unused signal warnings
  assign out_data = in_data;

  // Define a function, intentionally missing 'endfunction'
  function [3:0] calculate_value (input [3:0] val);
    calculate_value = val + 2;
    // FATAL VIOLATION: Keyword 'endfunction' is missing here.
    // SpyGlass rule STX_VE_564 is expected to trigger at this point.

  // Adding another construct (parameter) after the incomplete function
  // makes this example distinct from previous attempts and might influence
  // the reported error line.
  parameter DUMMY_PARAM = 5;

endmodule
