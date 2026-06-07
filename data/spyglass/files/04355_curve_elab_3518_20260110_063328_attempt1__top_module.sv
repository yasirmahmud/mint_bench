module top_module ();

    wire clk_in_h;
    wire clk_out_h;

    // Instantiating DCM_SP_dummy and overriding its parameter with a double value
    DCM_SP_dummy #(
        .CLKDV_DIVIDE (2.5) // This is the double-type value override that triggers ELAB_3518
    ) dcm_sp_inst ( // Instance name 'dcm_sp_inst' is explicitly mentioned in the rule description
        .CLKIN  (clk_in_h),
        .CLKOUT (clk_out_h)
    );

    // To avoid unused signals in the top module
    reg  test_clk = 1'b0;
    always #5 test_clk = ~test_clk;
    assign clk_in_h = test_clk;

    wire final_output = clk_out_h; // Use the output to prevent unused signal warning

endmodule
