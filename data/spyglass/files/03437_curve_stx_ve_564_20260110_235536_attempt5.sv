module curve_stx_ve_564_20260110_235536_attempt5 (
  input wire [3:0] in_data,
  output wire [3:0] out_data
);

  // Define a function, intentionally missing 'endfunction'
  function [3:0] simple_transform (input [3:0] val);
    simple_transform = val ^ 4'b1010;
    // FATAL VIOLATION: Keyword 'endfunction' is missing here.
    // SpyGlass rule STX_VE_564 is expected to trigger at this point.

  // Add an assign statement after the incomplete function definition.
  // This will cause the parser to expect 'endfunction' before 'assign',
  // triggering STX_VE_564.
  assign out_data = in_data;

endmodule
