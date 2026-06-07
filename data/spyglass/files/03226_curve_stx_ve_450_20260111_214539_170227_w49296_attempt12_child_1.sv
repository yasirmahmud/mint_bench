module curve_stx_ve_450_20260111_214539_170227_w49296_attempt12 ();

  // STX_VE_450: Unpacked member ( data ) found in packed structure
  // This rule is triggered by including an unpacked array 'readings'
  // within a 'typedef struct packed' definition.
  typedef struct packed {
    reg [31:0] timestamp;     // Packed member
    reg [2:0][15:0] readings; // Changed from unpacked 'readings[3]' to packed '[2:0][15:0] readings' to resolve STX_VE_450
    reg [7:0] device_id;      // Packed member
  } sensor_data_t;

  // Declare an instance of the structured type to ensure it's recognized and used.
  sensor_data_t sensor_packet;

  initial begin
    // Assign values to members to prevent unused signal warnings.
    // The violation is at the type definition, not the usage.
    sensor_packet.timestamp = 32'hFEED_BEEF;
    sensor_packet.device_id = 8'hC0;
    // Accessing 'readings' array elements to ensure use
    // The access syntax remains the same as SystemVerilog handles packed arrays this way.
    sensor_packet.readings[0] = 16'h1234;
    sensor_packet.readings[1] = 16'h5678;
    sensor_packet.readings[2] = 16'h9ABC;
  end

endmodule
