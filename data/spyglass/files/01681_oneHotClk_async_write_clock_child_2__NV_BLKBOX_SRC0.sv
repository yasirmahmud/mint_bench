// Definition for the black-box module NV_BLKBOX_SRC0
// This module is added to resolve SpyGlass ErrorAnalyzeBBox violation.
// It simply declares an output 'Y' without any internal logic,
// as its specific behavior is external to this design unit.
(* blackbox *)
module NV_BLKBOX_SRC0 (
  output Y
);
  // No internal logic is defined, as this is a placeholder for a black-box.
  // The actual source driving Y is external and not part of this module's RTL.
endmodule
