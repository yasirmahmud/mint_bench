module curve_w287b_20260111_105806_attempt3 (
    input wire i_data_a,
    input wire i_data_b,
    output wire o_sum_result
);

    // Instantiate my_logic_block
    // The output port 'carry_out' is intentionally left unconnected to trigger W287b
    my_logic_block u_half_adder (
        .in_a       (i_data_a),
        .in_b       (i_data_b),
        .sum_out    (o_sum_result), // Connected
        .carry_out  ()              // W287b violation: Instance output port 'carry_out' is not connected
    );

endmodule
