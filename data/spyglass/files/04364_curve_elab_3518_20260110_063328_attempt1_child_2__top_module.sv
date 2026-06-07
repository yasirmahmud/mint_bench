module top_module ();

    wire clk_in_h;
    wire clk_out_h;

    // Instantiating DCM_SP_dummy and overriding its parameter with an integer value
    // Fix for ELAB_3518: Changed 2.5 to an integer (2).
    DCM_SP_dummy #(
        .CLKDV_DIVIDE (2) // Changed to an integer value
    ) dcm_sp_inst (
        .CLKIN  (clk_in_h),
        .CLKOUT (clk_out_h)
    );

    reg  test_clk;

    // Fix for SYNTH_5143 (Initial block ignored for synthesis): 
    // The clock generation initial block is now conditional. 
    // For simulation, it generates the clock. For synthesis, clk_in_h is tied to '0' 
    // to prevent an undriven net warning and resolve SYNTH_5143, 
    // while preserving module interface.
    `ifndef SYNTHESIS
    initial begin
        test_clk = 1'b0;
        forever #5 test_clk = ~test_clk;
    end
    assign clk_in_h = test_clk;
    `else
    assign clk_in_h = 1'b0;
    `endif

    // Fix for W528 (Variable 'final_output' set but not read) and 
    // SYNTH_5143 (Initial block ignored for synthesis for monitor): 
    // The simulation-only 'final_output' wire and '$monitor' statement 
    // are now conditional, excluded during synthesis.
    `ifndef SYNTHESIS
    wire final_output = clk_out_h;
    initial begin
        $monitor("At %t ns, final_output = %b", $time, final_output);
    end
    `endif

endmodule
