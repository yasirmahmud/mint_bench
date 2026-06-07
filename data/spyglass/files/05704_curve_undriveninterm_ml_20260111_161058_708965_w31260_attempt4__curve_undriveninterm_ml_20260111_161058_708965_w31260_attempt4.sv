module curve_undriveninterm_ml_20260111_161058_708965_w31260_attempt4 (
    input wire clk,
    output wire out_data
);

    // Declare a wire that is never driven by any assignment.
    // Connecting this to an input terminal of an instantiated module
    // should trigger the UndrivenInTerm-ML violation.
    wire undriven_input_source;

    // Instantiate a sub-module. The 'input_pin_to_be_undriven' port will be
    // connected to 'undriven_input_source', which is not driven anywhere.
    leaf_module_for_undriven_term i_leaf (
        .clk_i(clk),
        .input_pin_to_be_undriven(undriven_input_source),
        .output_pin(out_data)
    );

endmodule
