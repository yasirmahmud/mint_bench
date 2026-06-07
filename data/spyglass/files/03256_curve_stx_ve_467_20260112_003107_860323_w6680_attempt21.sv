module curve_stx_ve_467_20260112_003107_860323_w6680_attempt21;

  // Scalar variables to be assigned, acting as the target for non-equivalent type assignments.
  reg     scalar_reg_target;
  integer scalar_int_target;

  // Unpacked arrays of equivalent base types, but fundamentally different aggregate structure
  // compared to scalars. These will be the source of the non-equivalent type assignments.
  reg     array_of_regs [0:1]; // An unpacked array of 1-bit registers
  integer array_of_ints [0:1]; // An unpacked array of integers

  initial begin
    // Initialize array elements to avoid 'unused signal' warnings for the source arrays.
    array_of_regs[0] = 1'b0;
    array_of_regs[1] = 1'b1;

    array_of_ints[0] = 10;
    array_of_ints[1] = 20;

    // FATAL: STX_VE_467 (1/2) - Non-equivalent data types in assignment operation.
    // Violation: Attempting to assign an unpacked array (array_of_regs) directly
    // to a scalar register (scalar_reg_target). An unpacked array represents a collection
    // of elements, while a scalar register holds a single value. These are non-equivalent types.
    scalar_reg_target = array_of_regs; // First violation for STX_VE_467

    // FATAL: STX_VE_467 (2/2) - Non-equivalent data types in assignment operation.
    // Violation: Attempting to assign an unpacked array (array_of_ints) directly
    // to a scalar integer (scalar_int_target). An unpacked array and a scalar integer
    // are fundamentally different data types in terms of structure.
    scalar_int_target = array_of_ints; // Second violation for STX_VE_467

    // Dummy reads for the target scalars to prevent 'unused signal' warnings
    // from other rules/tools, ensuring focus remains on STX_VE_467.
    if (scalar_reg_target) begin
      $display("DEBUG: scalar_reg_target is %b", scalar_reg_target);
    end else begin
      $display("DEBUG: scalar_reg_target is 0");
    end

    if (scalar_int_target == 0) begin
      $display("DEBUG: scalar_int_target is 0");
    end else begin
      $display("DEBUG: scalar_int_target is %d", scalar_int_target);
    end
  end

endmodule
