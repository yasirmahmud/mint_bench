module curve_stx_ve_450_20260112_000025_984089_w37744_attempt14 ();

  // Define a packed struct with an unpacked array member
  typedef struct packed {
    reg [15:0] base_address;       // Packed member
    reg [7:0] access_permissions;  // Packed member
    reg [31:0] data_registers[4];  // Unpacked array, triggers STX_VE_450
    reg [3:0] status_flags;        // Packed member
  } memory_config_t;

  // Instantiate the struct type to make it active, though the rule triggers on the typedef itself
  memory_config_t my_memory_config;

endmodule
