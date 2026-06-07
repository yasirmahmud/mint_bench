module top_level (
    input clk_i,
    output clk_o
);

    // Instantiating OSC_GENERATOR and overriding its parameter with a double value
    OSC_GENERATOR #(
        .DIV_FACTOR (1.234) // This is the double-type value override that triggers ELAB_3518
    ) dcm_sp_inst ( // Instance name 'dcm_sp_inst' is explicitly mentioned in the rule description
        .clk_in  (clk_i),
        
        .clk_out (clk_o)
    );

endmodule
