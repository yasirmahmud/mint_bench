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
        scalar_reg_target = 1.23;

        // STX_VE_467 violation 2: Non-equivalent data types in assignment operation.
        // Assigning a 'real' type variable (real_source) to an 'integer' type (scalar_int_target).
        // Similar to the above, this assignment involves an implicit type conversion.
        scalar_int_target = real_source;

        dummy_out = 1'b0; // Assign to dummy_out to avoid unused signal warnings
    end

endmodule
