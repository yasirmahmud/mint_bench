module curve_stx_ve_467_20260111_220020_557997_w28836_attempt16 (
    output reg dummy_out // Placeholder output to ensure module is connectable
);

    reg         scalar_reg_target;
    integer     scalar_int_target;
    real        real_source;

    initial begin
        real_source = 543.21;

        // STX_VE_467 violation 1: Non-equivalent data types in assignment operation.
        // Assigning a 'real' literal (1.23) to a 'reg' type (scalar_reg_target).
        // Verilog performs an implicit truncation/conversion, which SpyGlass flags as a type mismatch.
        // Fixed: Explicitly assign the truncated integer value (1) as a 1-bit binary literal to the 1-bit 'reg'.
        scalar_reg_target = 1'b1;

        // STX_VE_467 violation 2: Non-equivalent data types in assignment operation.
        // Assigning a 'real' type variable (real_source) to an 'integer' type (scalar_int_target).
        // Similar to the above, this assignment involves an implicit type conversion.
        // Fixed: Explicitly cast 'real' to 'int' using SystemVerilog casting to ensure type compatibility and truncation.
        scalar_int_target = int'(real_source);

        // W528 violation fix: Use 'scalar_reg_target' and 'scalar_int_target' in the assignment to 'dummy_out'
        // to avoid "set but not read" warnings. This maintains the functional behavior of assigning values
        // to scalar_reg_target and scalar_int_target, and uses them in a placeholder output.
        // The final value of dummy_out will be '1'b1' (since scalar_reg_target is 1'b1 and scalar_int_target[0] is 1'b1).
        dummy_out = scalar_reg_target | scalar_int_target[0];
    end

endmodule
