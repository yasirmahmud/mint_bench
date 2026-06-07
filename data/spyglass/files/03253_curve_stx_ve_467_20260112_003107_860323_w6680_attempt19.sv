module curve_stx_ve_467_20260112_003107_860323_w6680_attempt19;

  // Scalar data types to receive the invalid assignments
  integer scalar_int_sink;
  reg     scalar_reg_sink;

  // Unpacked array data types
  reg [7:0] unpacked_reg_array [0:3];
  integer   unpacked_int_array [0:1];

  initial begin
    // Initialize array elements to avoid unused signal warnings for array elements
    unpacked_reg_array[0] = 8'h01;
    unpacked_reg_array[1] = 8'h02;
    unpacked_reg_array[2] = 8'h03;
    unpacked_reg_array[3] = 8'h04;

    unpacked_int_array[0] = 10;
    unpacked_int_array[1] = 20;

    // FATAL: STX_VE_467 (1/2) - Non-equivalent data types in assignment operation.
    // Violation: Assigning an unpacked array (unpacked_reg_array) of 'reg [7:0]' 
    // to a scalar 'integer' type (scalar_int_sink). An unpacked array is a collection 
    // of elements, while an integer is a single, integral scalar value. Verilog does 
    // not allow direct assignment of an unpacked array to a scalar.
    scalar_int_sink = unpacked_reg_array; // Violation 1

    // FATAL: STX_VE_467 (2/2) - Non-equivalent data types in assignment operation.
    // Violation: Assigning an unpacked array (unpacked_int_array) of 'integer' 
    // to a scalar 'reg' type (scalar_reg_sink). An unpacked array cannot be 
    // directly assigned to a single scalar bit-vector type like 'reg'.
    scalar_reg_sink = unpacked_int_array; // Violation 2

    // Dummy reads to ensure 'scalar_int_sink' and 'scalar_reg_sink' are considered used
    // by tools, preventing 'unused signal' warnings for these variables. The actual
    // values after the invalid assignment might be 'x' or tool-dependent.
    if (scalar_int_sink == 0) begin
      $display("DEBUG: scalar_int_sink is zero or unknown.");
    end
    if (scalar_reg_sink == 1'b0) begin
      $display("DEBUG: scalar_reg_sink is zero or unknown.");
    end
  end

endmodule
