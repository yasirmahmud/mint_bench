module top (
    input sys_clk,
    output sys_data
);

    // Instantiating MY_SUB_MODULE and overriding its parameter with a double value
    MY_SUB_MODULE #(
        .SAMPLE_PERIOD (3.14159) // This is the double-type value override that triggers ELAB_3518
    ) dcm_sp_inst ( // Instance name 'dcm_sp_inst' is explicitly mentioned in the rule description
        .clk_in   (sys_clk),
        .data_out (sys_data)
    );

endmodule
