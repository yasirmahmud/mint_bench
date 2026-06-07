module curve_starc05_2_10_1_4a_20260111_082442_attempt4 (
  input wire my_signal
);

  // The initial block and the comparison with 'z' have been removed.
  // Initial blocks are ignored for synthesis and comparisons with 'x' or 'z'
  // are not allowed in synthesizable RTL by STARC rules. Removing this
  // non-synthesizable construct maintains the synthesizable functional
  // behavior of the module while resolving all reported SpyGlass violations.

endmodule
