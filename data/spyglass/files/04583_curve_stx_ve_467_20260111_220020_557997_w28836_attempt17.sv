module curve_stx_ve_467_20260111_220020_557997_w28836_attempt17 (
    input wire enable,
    output reg dummy_out
);

    reg         scalar_reg_target; // Target for real to reg assignment
    integer     scalar_int_target; // Target for real literal to integer assignment
    real        real_source;       // Source for real value

    always @* begin
        // Assign a real value to the real_source variable.
        // This assignment itself is type-compatible.
        real_source = 123.45;

        // STX_VE_467 violation 1: Non-equivalent data types in assignment operation.
        // Assigning a 'real' type variable (real_source) to a 'reg' type (scalar_reg_target).
        // Verilog performs an implicit truncation/conversion, which SpyGlass flags as a type mismatch.
        scalar_reg_target = real_source; // FATAL: STX_VE_467

        // STX_VE_467 violation 2: Non-equivalent data types in assignment operation.
        // Assigning a 'real' literal (67.89) to an 'integer' type (scalar_int_target).
        // This also involves an implicit type conversion (truncation).
        scalar_int_target = 67.89; // FATAL: STX_VE_467

        // Use all internal variables to prevent W528 (set but not read) warnings.
        // The 'enable' input is included in a trivial operation to avoid an unused input warning.
        dummy_out = (scalar_reg_target + scalar_int_target) & (enable ? 1'b1 : 1'b0);
    end

endmodule
