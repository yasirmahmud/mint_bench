`define MY_SETTING 50

module curve_wrn_26_20260111_032823_attempt4 ();

  // This redefinition of MY_SETTING will trigger WRN_26
  `define MY_SETTING 100

endmodule
