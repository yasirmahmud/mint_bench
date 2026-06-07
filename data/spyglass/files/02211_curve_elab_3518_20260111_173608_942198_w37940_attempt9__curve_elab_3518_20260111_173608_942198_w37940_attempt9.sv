module curve_elab_3518_20260111_173608_942198_w37940_attempt9 (
    input clk_sys,
    output divided_clk_sys
);

    // ELAB_3518: Double type value (3.5) used for overriding parameter MY_DIVIDER.
    MY_DCM_LIKE_MODULE #(.MY_DIVIDER(3.5)) dcm_sp_inst (
        .clk_in(clk_sys),
        .clk_out(divided_clk_sys)
    );

endmodule
