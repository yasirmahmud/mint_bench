module curve_stx_ve_450_20260112_000025_984089_w37744_attempt13 ();

  // A packed struct with an unpacked array member to trigger STX_VE_450
  typedef struct packed {
    reg [7:0] mode_setting;        // Packed member
    reg [3:0] enable_flags;
    reg [15:0] calibration_data[2]; // This is the unpacked member triggering the violation
    reg [0:0] busy_status;
  } control_block_config_t;

  control_block_config_t system_control_config; // Instance of the struct type

endmodule
