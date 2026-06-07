module curve_synth_130_20260111_183735_151706_w47100_attempt10 (
    output [4:0] out_data,
    input        in_data,
    input        control
);

    genvar i;
    generate
        for (i = 0; i < 5; i = i + 1) begin : nmos_gate_instance
            // Each nmos instance will trigger a SYNTH_130 violation
            // (nmos gate types are not supported)
            nmos nmos_inst (out_data[i], in_data, control);
        end
    endgenerate

endmodule
