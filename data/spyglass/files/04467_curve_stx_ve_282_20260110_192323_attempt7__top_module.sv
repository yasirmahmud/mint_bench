module top_module (
    input  top_main_input,
    input  top_second_input, // Input for the second instance
    output top_main_output,
    output top_second_output // Output for the second instance
);

    // Instance 0: Triggers STX_VE_282
    // The port name '.in' is used in the instance, but 'sub_module' does not have a port named 'in'.
    // The signal 'top_main_input' is a top-level input, mirroring the provided context example.
    sub_module i_sub_0 (
        .data_input_arg  (top_main_input),
        .data_output_arg (top_main_output),
        .in              (top_main_input) // Violation 1: 'in' is not a port of 'sub_module'
    );

    // Instance 1: Triggers a second STX_VE_282 violation
    sub_module i_sub_1 (
        .data_input_arg  (top_second_input),
        .data_output_arg (top_second_output),
        .in              (top_second_input) // Violation 2: 'in' is not a port of 'sub_module'
    );

endmodule
