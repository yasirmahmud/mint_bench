`define CONFIG_SETTING "DEBUG"

module curve_wrn_26_20260111_032823_attempt2 ();

  // Redefining CONFIG_SETTING will trigger WRN_26
  `define CONFIG_SETTING "RELEASE"

  // Use the macro to avoid potential unused warnings, if any
  parameter string current_mode = `CONFIG_SETTING;

endmodule
