module top_module_w156_attempt11 (
    input [3:0] input_from_env,
    output [3:0] output_to_env
);

    // This net is declared with LSB:MSB indexing
    wire [0:3] reversed_data_bus_net;

    // This net is for the output of the sub-module
    wire [3:0] sub_module_output_data;

    // Connect the top-level input to the reversed-indexed net
    assign reversed_data_bus_net = input_from_env;

    // Connect the sub-module output to the top-level output
    assign output_to_env = sub_module_output_data;

    // Instantiate sub_module_w156_attempt11
    // The port 'standard_data_bus_in' in the sub-module is [3:0] (MSB:LSB)
    // The connected net 'reversed_data_bus_net' in this module is [0:3] (LSB:MSB)
    // This connection constitutes a reversed bus connection and will trigger W156.
    sub_module_w156_attempt11 u_instance (
        .standard_data_bus_in (reversed_data_bus_net), // W156 violation expected here
        .data_processed_out   (sub_module_output_data)
    );

endmodule
