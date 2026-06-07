module curve_stx_ve_361_20260111_203642_841410_w36056_attempt7 (
    input in_signal,
    output out_signal
);

    // Declare a wire, which cannot be assigned procedurally
    wire intermediate_wire;

    // This always block attempts to assign to a wire, triggering STX_VE_361
    always @(*) begin
        intermediate_wire = in_signal; // VIOLATION: Procedural assignment to a net (wire) is forbidden
    end

    // Use the intermediate_wire to avoid an unused signal warning for 'intermediate_wire'
    assign out_signal = intermediate_wire;

endmodule
