module curve_w287b_20260111_105806_attempt4 (
    input wire i_input_x,
    input wire i_input_y,
    output wire o_and_result
);

    // Declare a dummy wire for the intentionally unused output to resolve W287b
    wire unused_out_or_signal;

    // Instantiate sub_logic
    // The output port 'out_or' is now connected to a dummy wire to resolve W287b
    sub_logic u_combinational_block (
        .in_a      (i_input_x),
        .in_b      (i_input_y),
        .out_and   (o_and_result), // Connected
        .out_or    (unused_out_or_signal) // W287b violation resolved by connecting to dummy wire
    );

endmodule
