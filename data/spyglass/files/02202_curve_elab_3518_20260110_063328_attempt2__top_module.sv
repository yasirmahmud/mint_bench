module top_module (
    input clk_in,
    output clk_out
);

    // Instantiating DCM_SP_dummy and overriding its parameter with a double value
    DCM_SP_dummy #(
        .CLKDV_DIVIDE (2.5) // This is the double-type value override that triggers ELAB_3518
    ) dcm_sp_inst ( // Instance name 'dcm_sp_inst' is explicitly mentioned in the rule description
        .CLKIN  (clk_in),
        .CLKOUT (clk_out)
    );

endmodule
