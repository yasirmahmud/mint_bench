module curve_w287b_20260111_105806_attempt5 (
    input wire i_main_input,
    output wire o_output_a,
    output wire o_output_c
);

    // Instantiate data_splitter
    // The output port 'out_b' is intentionally left unconnected to trigger W287b
    data_splitter u_splitter (
        .in_data (i_main_input),
        .out_a   (o_output_a),   // Connected
        .out_b   (),             // W287b violation: Instance output port 'out_b' is not connected
        .out_c   (o_output_c)    // Connected
    );

endmodule
