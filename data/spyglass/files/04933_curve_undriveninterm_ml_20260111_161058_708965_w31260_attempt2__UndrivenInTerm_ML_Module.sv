module UndrivenInTerm_ML_Module (
    input wire top_level_input,
    output wire top_level_output,
    output wire top_level_dummy_out
);

    wire undriven_net_to_instance_input; // This wire is declared but never driven.

    // Instantiate sub_mod, connecting its input terminal to an undriven net.
    // This will trigger the UndrivenInTerm-ML violation on i_sub_inst.sub_input.
    sub_mod i_sub_inst (
        .sub_input  (undriven_net_to_instance_input), // UNDRIVEN INPUT TERMINAL
        .sub_output (top_level_output)                // Connect output to top_level_output
    );

    // Use top_level_input to avoid an unused signal warning for it.
    assign top_level_dummy_out = top_level_input;

    // top_level_output is driven by i_sub_inst.sub_output.

endmodule
