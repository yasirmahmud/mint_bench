module wrapper_module (
    input top_clk,
    output top_output
);

    // Instantiating child_module and overriding its parameter with a double value
    child_module #(
        .DELAY_PARAM (2.5) // This is the double-type value override that triggers ELAB_3518
    ) dcm_sp_inst ( // Instance name 'dcm_sp_inst' is explicitly mentioned in the rule description
        .clk         (top_clk),
        .output_data (top_output)
    );

endmodule
