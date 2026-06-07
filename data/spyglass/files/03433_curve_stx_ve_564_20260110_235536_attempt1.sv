module curve_stx_ve_564_20260110_235536_attempt1 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Use the input/output to avoid unused signal warnings
  assign data_out = data_in;

  // Define the function 'outer_func', intentionally missing 'endfunction'
  function [7:0] outer_func (input [7:0] val);
    outer_func = val + 1;
    // FATAL VIOLATION: Keyword 'endfunction' is missing here.
    // SpyGlass rule STX_VE_564 is expected to trigger at this point or when 'endmodule' is encountered.

endmodule
