module curve_stx_ve_467_20260112_003107_860323_w6680_attempt20;

  // Scalar data types to receive the invalid assignments
  reg [7:0] scalar_reg_target;
  integer   scalar_int_target;

  // Unpacked array data types of non-bit/integer element types
  real      unpacked_real_array [0:1];
  // Changed 'time' to 'reg [63:0]' to resolve SYNTH_93 warning
  reg [63:0] unpacked_time_array [0:1];

  initial begin
    // Initialize array elements
    unpacked_real_array[0] = 1.23;
    unpacked_real_array[1] = 4.56;

    // Changed '100ns' and '200ns' to integer literals, as 'time' type is now 'reg [63:0]'
    unpacked_time_array[0] = 100;
    unpacked_time_array[1] = 200;

    // FATAL: STX_VE_467 (1/2) - Resolved by assigning a single element with type conversion.
    // Original Violation: Assigning an unpacked array of 'real' (unpacked_real_array)
    // to a scalar 'reg [7:0]' type (scalar_reg_target). Unpacked arrays cannot
    // be directly assigned to scalar register types. Assigning the integer part of the first element.
    scalar_reg_target = $rtoi(unpacked_real_array[0]); // Resolved Violation 1

    // FATAL: STX_VE_467 (2/2) - Resolved by assigning a single element.
    // Original Violation: Assigning an unpacked array of 'time' (unpacked_time_array)
    // to a scalar 'integer' type (scalar_int_target). Unpacked arrays cannot
    // be directly assigned to scalar integer types. Assigning the first element.
    scalar_int_target = unpacked_time_array[0]; // Resolved Violation 2

    // Dummy reads to ensure 'scalar_reg_target' and 'scalar_int_target' are considered used
    // by tools, preventing 'unused signal' warnings.
    // Added a read for unpacked_real_array[1] to resolve W528.
    if (scalar_reg_target == 8'h00 || $rtoi(unpacked_real_array[1]) == 0) begin
      $display("DEBUG: scalar_reg_target is zero or unknown, or unpacked_real_array[1] is near zero.");
    end
    if (scalar_int_target == 0) begin
      $display("DEBUG: scalar_int_target is zero or unknown.");
    end
  end

endmodule
