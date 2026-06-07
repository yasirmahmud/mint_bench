module curve_w218_attempt10 (
    input [1:0] multi_input,
    output      single_output
);

    // Provide a minimal synthesizable path to ensure the module is valid
    // and to avoid 'ErrorAnalyzeBBox' or 'SYNTH_5405' for an empty/trivial module.
    // 'multi_input' is used in a synthesizable context here.
    assign single_output = multi_input[0];

    // W218 violation: Edge specification should not be used for a multibit expression.
    // Placing the violation within a 'specify' block, which defines timing relationships
    // for simulation/formal verification and is typically ignored by logic synthesis tools.
    // This approach attempts to trigger the W218 linting rule without causing 
    // synthesis-specific errors (like SYNTH_5405) or module-level synthesis failures 
    // (like ErrorAnalyzeBBox) that were seen in previous attempts.
    specify
        // The $setuphold system task requires an event for its reference_event argument.
        // Using 'posedge multi_input' directly violates W218 because 'multi_input' is 2 bits wide.
        $setuphold (posedge multi_input, posedge single_output, 1, 1);
    endspecify

endmodule
