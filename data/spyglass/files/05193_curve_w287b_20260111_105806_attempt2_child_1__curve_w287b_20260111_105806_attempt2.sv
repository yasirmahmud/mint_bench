module curve_w287b_20260111_105806_attempt2 (
    input wire main_clk,
    input wire main_enable,
    output wire dummy_output
);

    // Wire to connect the unused output port
    wire unused_submodule_output;

    // Instantiate my_submodule
    // The output port 'result_q' is now connected to resolve W287b
    my_submodule u_inst_0 (
        .clk        (main_clk),
        .enable     (main_enable),
        .result_q   (unused_submodule_output) // W287b violation resolved
    );

    // Drive an output to avoid an unused signal warning for 'dummy_output'
    // and to ensure 'main_clk' and 'main_enable' are not considered entirely unused.
    assign dummy_output = main_clk & main_enable;

endmodule
