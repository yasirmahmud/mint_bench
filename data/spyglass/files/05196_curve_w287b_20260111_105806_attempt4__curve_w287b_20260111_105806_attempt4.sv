module curve_w287b_20260111_105806_attempt4 (
    input wire i_input_x,
    input wire i_input_y,
    output wire o_and_result
);

    // Instantiate sub_logic
    // The output port 'out_or' is intentionally left unconnected to trigger W287b
    sub_logic u_combinational_block (
        .in_a      (i_input_x),
        .in_b      (i_input_y),
        .out_and   (o_and_result), // Connected
        .out_or    ()              // W287b violation: Instance output port 'out_or' is not connected
    );

endmodule
