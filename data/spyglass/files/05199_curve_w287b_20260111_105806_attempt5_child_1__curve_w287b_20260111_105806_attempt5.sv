module curve_w287b_20260111_105806_attempt5 (
    input wire i_main_input,
    output wire o_output_a,
    output wire o_output_c
);

    // Declare a dummy wire to connect the unused output port
    wire dummy_out_b;

    // Instantiate data_splitter
    data_splitter u_splitter (
        .in_data (i_main_input),
        .out_a   (o_output_a),   // Connected
        .out_b   (dummy_out_b),  // Connected to dummy wire to resolve W287b
        .out_c   (o_output_c)    // Connected
    );

endmodule
