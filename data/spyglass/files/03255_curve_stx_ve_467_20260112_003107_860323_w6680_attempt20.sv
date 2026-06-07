module curve_stx_ve_467_20260112_003107_860323_w6680_attempt20;

  // Scalar data types to receive the invalid assignments
  reg [7:0] scalar_reg_target;
  integer   scalar_int_target;

  // Unpacked array data types of non-bit/integer element types
  real      unpacked_real_array [0:1];
  time      unpacked_time_array [0:1];

  initial begin
    // Initialize array elements to avoid unused signal warnings
    unpacked_real_array[0] = 1.23;
    unpacked_real_array[1] = 4.56;

    unpacked_time_array[0] = 100ns;
    unpacked_time_array[1] = 200ns;

    // FATAL: STX_VE_467 (1/2) - Non-equivalent data types in assignment operation.
    // Violation: Assigning an unpacked array of 'real' (unpacked_real_array)
    // to a scalar 'reg [7:0]' type (scalar_reg_target). Unpacked arrays cannot
    // be directly assigned to scalar register types, as they represent a collection
    // of values, not a single scalar value.
    scalar_reg_target = unpacked_real_array; // Violation 1

    // FATAL: STX_VE_467 (2/2) - Non-equivalent data types in assignment operation.
    // Violation: Assigning an unpacked array of 'time' (unpacked_time_array)
    // to a scalar 'integer' type (scalar_int_target). Unpacked arrays cannot
    // be directly assigned to scalar integer types.
    scalar_int_target = unpacked_time_array; // Violation 2

    // Dummy reads to ensure 'scalar_reg_target' and 'scalar_int_target' are considered used
    // by tools, preventing 'unused signal' warnings.
    if (scalar_reg_target == 8'h00) begin
      $display("DEBUG: scalar_reg_target is zero or unknown.");
    end
    if (scalar_int_target == 0) begin
      $display("DEBUG: scalar_int_target is zero or unknown.");
    end
  end

endmodule
