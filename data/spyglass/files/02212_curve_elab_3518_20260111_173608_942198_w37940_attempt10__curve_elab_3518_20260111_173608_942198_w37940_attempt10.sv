module curve_elab_3518_20260111_173608_942198_w37940_attempt10 (
    input sys_clk,
    output divided_out
);

    // ELAB_3518: This line triggers the violation.
    // A double type value (5.5) is used to override the integer parameter DIV_FACTOR.
    MY_FREQ_DIVIDER #(.DIV_FACTOR(5.5)) dcm_sp_inst (
        .clk(sys_clk),
        .out_signal(divided_out)
    );

endmodule
