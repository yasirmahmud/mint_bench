`define MAX_WIDTH 8

module curve_wrn_26_20260111_032823_attempt5 ();

  // This redefinition of the macro MAX_WIDTH will trigger WRN_26
  `define MAX_WIDTH 16

endmodule
