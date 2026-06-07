`define MY_MACRO 10

module curve_wrn_26_20260111_032823_attempt1 ();

  // Redefining MY_MACRO will trigger WRN_26
  `define MY_MACRO 20

endmodule
