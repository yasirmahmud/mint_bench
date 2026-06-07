// This module is intentionally defined as a black box with an empty body.
// It has a port list but no internal logic or declarations between 'module ... ;' and 'endmodule'.
// This structure is designed to specifically trigger the WarnAnalyzeBBox violation,
// which flags design units with an empty definition.
module empty_bbox_module (
  input wire in_data,
  output wire out_data
);
  // The body of this module is intentionally empty.
endmodule // empty_bbox_module
