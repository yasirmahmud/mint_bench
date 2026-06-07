module curve_w287b_20260111_105806_attempt3 (
    input wire i_data_a,
    input wire i_data_b,
    output wire o_sum_result
);

    // Declare a wire to connect the unused output port and resolve W287b
    wire unconnected_carry_out;

    // Instantiate my_logic_block
    my_logic_block u_half_adder (
        .in_a       (i_data_a),
        .in_b       (i_data_b),
        .sum_out    (o_sum_result),
        .carry_out  (unconnected_carry_out) // Connected to resolve W287b violation
    );

endmodule
