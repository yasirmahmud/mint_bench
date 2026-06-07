module curve_stx_ve_361_20260111_203642_841410_w36056_attempt10 (
    output out_data
);

    // Declare an explicit 'reg' type variable to allow procedural assignment.
    reg internal_net;

    // Continuously assign the output to the internal net.
    // This is allowed and does not trigger a violation.
    assign out_data = internal_net;

    // This 'initial' block now performs a procedural assignment to 'internal_net'.
    // Since 'internal_net' is now a 'reg' (variable type), this procedural assignment
    // is valid and resolves the STX_VE_361 violation.
    initial begin
        internal_net = 1'b0;
    end

endmodule
