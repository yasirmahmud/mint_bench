module curve_w287b_20260111_105806_attempt5 (
    input wire i_main_input,
    output wire o_output_a,
    output wire o_output_c
);

    // Instantiate data_splitter
    data_splitter u_splitter (
        .in_data (i_main_input),
        .out_a   (o_output_a),   // Connected
        .out_b   (),             // Unconnected, resolves W287b and W528
        .out_c   (o_output_c)    // Connected
    );

endmodule
