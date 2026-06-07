module curve_stx_ve_450_20260110_114643_attempt3;

  // STX_VE_450: Unpacked member (sample_data) found in packed structure
  // This typedef defines a packed structure (using 'packed' keyword)
  // that contains an unpacked array 'sample_data' (declared as reg [7:0] sample_data[0:3]).
  // The presence of an unpacked member ('sample_data') within a packed structure definition
  // is the direct cause of the STX_VE_450 violation.
  typedef struct packed {
    reg [31:0] timestamp;
    reg [7:0] sample_data[0:3]; // Unpacked array member within a packed structure. This triggers the rule.
    reg error_detected;
  } sensor_reading_t;

  // Declare an instance of the struct to ensure the typedef is used
  // and to avoid potential 'unused type' or 'unused signal' warnings.
  sensor_reading_t current_reading;

  // Simple initial block to assign values to the struct members.
  // This avoids unused signal warnings and provides minimal functionality.
  initial begin
    current_reading.timestamp = 32'h12345678;
    current_reading.sample_data[0] = 8'h10;
    current_reading.sample_data[1] = 8'h20;
    current_reading.sample_data[2] = 8'h30;
    current_reading.sample_data[3] = 8'h40;
    current_reading.error_detected = 1'b0;
  end

endmodule
