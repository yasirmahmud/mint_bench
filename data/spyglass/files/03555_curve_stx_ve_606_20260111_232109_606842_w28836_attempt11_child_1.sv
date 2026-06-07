module curve_stx_ve_606_20260111_232109_606842_w28836_attempt11 (
    input sel,
    input data_in,
    output data_out
);

    // Declare c_coeff_2 explicitly as a 1-bit wire to resolve STX_VE_606 violation.
    // In Verilog-2001, it would be implicitly declared as such, with an undriven value 'z'.
    wire c_coeff_2;

    assign data_out = sel ? data_in : c_coeff_2;

endmodule
