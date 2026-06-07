module curve_stx_ve_647_20260111_090703_attempt1 (
    signal_a,
    signal_b
);

    // Standard Verilog-2001 port declarations
    input signal_a;
    output signal_b;

    // This declaration triggers STX_VE_647.
    // 'violating_input' is declared as input, but its name is not present
    // in the module header's port list (signal_a, signal_b).
    input violating_input;

    wire temp_wire;

    // Use all signals to avoid unused signal warnings
    assign temp_wire = signal_a & violating_input;
    assign signal_b = temp_wire;

endmodule
