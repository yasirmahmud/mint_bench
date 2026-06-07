module curve_w287b_20260111_105806_attempt1 (
    input wire top_input,
    output wire top_output
);
    // Declare a wire to connect to the previously unconnected output port of the child_module
    wire child_out_z_conn;

    // Instantiate child_module
    // The output port 'out_z' is intentionally left unconnected to trigger W287b
    child_module u_instance (
        .in_a  (top_input),
        .out_z (child_out_z_conn) // W287b violation resolved: Instance output port 'out_z' is now connected
    );

    // Ensure 'top_output' is driven to avoid unused signal warnings for it.
    // Also ensures 'top_input' is fully utilized.
    assign top_output = top_input;

endmodule
